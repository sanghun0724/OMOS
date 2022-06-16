//
//  searchViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import RxSwift
import UIKit

enum SearchType {
    case main
    case me
}

class SearchViewController: BaseViewController {
    let viewModel: SearchViewModel
    let selfView = SearchListView()
    let loadingView = LoadingView()

    init(viewModel: SearchViewModel, searchType: SearchType) {
        self.viewModel = viewModel
        self.viewModel.searchType = searchType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.enableScrollWhenKeyboardAppeared(scrollView: selfView.tableView)
        self.enableScrollWhenKeyboardAppeared(scrollView: selfView.bestTableView)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeListeners()
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.searchViewController.searchBar.delegate = self
        navigationItem.rightBarButtonItems?.removeAll()
        selfView.emptyView.isHidden = true
        selfView.emptyView.descriptionLabel.text = "검색 결과가 없습니다."
        selfView.emptyView.imageView.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selfView.searchViewController.isActive = true
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        selfView.searchViewController.isActive = false
        selfView.searchViewController.searchBar.resignFirstResponder()
    }

    override func configureUI() {
        view.addSubview(selfView)
        view.addSubview(loadingView)
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        selfView.bestTableView.delegate = self
        selfView.bestTableView.dataSource = self

        selfView.searchViewController.delegate = self
        selfView.searchViewController.searchResultsUpdater = self
        selfView.searchViewController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = selfView.searchViewController.searchBar
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.hidesBackButton = true

        selfView.frame = view.bounds
        loadingView.frame = view.bounds
    }

    override func bind() {
        let isSearchEmpty = selfView.searchViewController.searchBar.rx.text
            .throttle(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .map { text -> Bool in
                !(text?.isEmpty ?? true)
            }.distinctUntilChanged()

        isSearchEmpty.subscribe(onNext: { [weak self] valid in
            self?.selfView.bestTableView.isHidden = valid
        }).disposed(by: disposeBag)

        selfView.searchViewController.searchBar.rx.text
            .debounce(.milliseconds(280), scheduler: MainScheduler.instance) // 요청 오버헤드 방지
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe(onNext: { owner, text in
                guard let text = text else {
                    return
                }

                owner.viewModel.trackSearchFetch(request: .init(keyword: text, limit: 10, offset: 0, type: 1))
            }).disposed(by: disposeBag)

        viewModel.searchTrack
            .subscribe(onNext: { [weak self] _  in
                self?.selfView.tableView.reloadData()
            }).disposed(by: disposeBag)

        viewModel.errorMessage
            .subscribe(onNext: { errorMessage in
                guard let errorMessage = errorMessage, !errorMessage.isEmpty else {
                    return
                }
                print("search Error: \(errorMessage)")
            }).disposed(by: disposeBag)

        viewModel.allLoading
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe(onNext: { owner, loading in
                print("loading\(loading)")
                owner.loadingView.isHidden = !loading
            }).disposed(by: disposeBag)

//        viewModel.isEmpty
//            .withUnretained(self)
//            .subscribe(onNext: { owner,empty in
//                guard let isTextEmpty = owner.selfView.searchViewController.searchBar.text?.isEmpty else { return }
//                if !isTextEmpty {
//                    print("test")
//                    owner.selfView.emptyView.isHidden = !empty
//                }
//            }).disposed(by: disposeBag)
    }

    func addContentsView() {
        let topTabView = TopTabViewController(viewModel: self.viewModel )
        addChild(topTabView)
        self.view.addSubview(topTabView.view)
        topTabView.view.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
            topTabView.didMove(toParent: self)
        }
    }

    private func removeContentsView() {
    }
}

extension SearchViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.currentTrack = []
        viewModel.currentArtist = []
        viewModel.currentAlbum = []
        viewModel.searchAllResult(keyword: searchBar.text ?? "")
        viewModel.currentKeyword = searchBar.text ?? ""
        if self.children.isEmpty {
            self.addContentsView()
            self.selfView.isHidden = true
        }
        if let child = self.children.first {
            child.view?.isHidden = false
            self.selfView.isHidden = true
        }
    }

//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//
//
//    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let child = self.children.first {
            child.view?.isHidden = true
            self.selfView.isHidden = false
        }
    }
}
