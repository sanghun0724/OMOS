//
//  searchViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import UIKit
import RxSwift

class SearchViewController:BaseViewController {
    
    let viewModel:SearchViewModel
    let selfView = SearchListView()
    
    init(viewModel:SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.enableScrollWhenKeyboardAppeared(scrollView: selfView.tableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeListeners()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selfView.searchViewController.isActive = true
    }
    
    override func configureUI() {
        view.addSubview(selfView)
        
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        
        selfView.searchViewController.delegate = self
        selfView.searchViewController.searchResultsUpdater = self
       // selfView.searchViewController.searchBar.delegate = self
        
        navigationItem.searchController = selfView.searchViewController
        
        navigationItem.rightBarButtonItems?.removeAll()
        selfView.frame = view.bounds
    }
    
    func bind() {
        selfView.searchViewController.searchBar.rx.setDelegate(self).disposed(by: disposeBag)
        
        selfView.searchViewController.searchBar.rx.text
            .debounce(.milliseconds(300),scheduler:MainScheduler.instance) //요청 오버헤드 방지
            .withUnretained(self)
            .subscribe(onNext: { owner,text in
                guard let text = text else {
                    return
                }
                print(text)
                owner.viewModel.searchQeuryChanged(query: text)
            }).disposed(by: disposeBag)
        
        viewModel.errorMessage
            .subscribe(onNext: { errorMessage in
                guard let errorMessage = errorMessage , !errorMessage.isEmpty else {
                    return
                }
                print("search Error: \(errorMessage)")
            }).disposed(by: disposeBag)
        
        viewModel.musics
            .withUnretained(self)
            .subscribe(onNext: { owner,musics in
                owner.selfView.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        
        viewModel.loading
            .withUnretained(self)
            .subscribe(onNext: { owner,loading in
                print("loading\(loading)")
                owner.selfView.loadingView.isHidden = !loading
            }).disposed(by: disposeBag)
        
        viewModel.isEmpty
            .withUnretained(self)
            .subscribe(onNext: { owner,empty in
                owner.selfView.emptyView.isHidden = !empty
            }).disposed(by: disposeBag)
    }
    
}



extension SearchViewController:UISearchControllerDelegate ,UISearchBarDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async
        { [weak self] in
            self?.selfView.searchViewController.searchBar.becomeFirstResponder()

        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension SearchViewController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
