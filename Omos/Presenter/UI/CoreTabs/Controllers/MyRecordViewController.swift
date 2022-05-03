//
//  MyRecordViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import UIKit

class MyRecordViewController: BaseViewController {
    private let selfView = MyRecordView()
    let viewModel: MyRecordViewModel
    var myRecord: [MyRecordRespone] = []

    init(viewModel: MyRecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        configureUI()
        setRightItems()
        setRefreshControl()
        viewModel.myRecordFetch(userid: UserDefaults.standard.integer(forKey: "user"))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.integer(forKey: "reload") == 1 {
            print("this is work")
            viewModel.myRecordFetch(userid: Account.currentUser)
            selfView.tableView.reloadData()
            UserDefaults.standard.removeObject(forKey: "reload")
        }
        self.tabBarController?.tabBar.isHidden = false
    }

    func setRefreshControl() {
        self.selfView.tableView.refreshControl = UIRefreshControl()
        self.selfView.tableView.refreshControl?.addTarget(self, action: #selector(didPullRefresh), for: .valueChanged)
    }

    func setRightItems() {
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(didTapSearchButton))
        searchButton.tintColor = .white
        let createButton = UIBarButtonItem(image: UIImage(named: "plus-square"), style: .plain, target: self, action: #selector(didTapCreateButton))
        createButton.tintColor = .white
        self.navigationItem.rightBarButtonItems = [createButton]
    }

    @objc
    func didPullRefresh() {
        viewModel.myRecordFetch(userid: Account.currentUser)
    }

    @objc
    func didTapCreateButton() {
        let vc = SearchViewController(viewModel: SearchViewModel(usecase: SearchUseCase(searchRepository: SearchRepositoryImpl(searchAPI: SearchAPI()))), searchType: .me)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc
    func didTapSearchButton() {
        print("search")
    }

    override func configureUI() {
        view.addSubview(selfView)

        selfView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
    }

    func bind() {
        viewModel.myRecords.subscribe(onNext: { [weak self] info in
            self?.myRecord = info
            DispatchQueue.main.async {
                self?.selfView.tableView.refreshControl?.endRefreshing()
                self?.selfView.tableView.reloadData()
            }
        }).disposed(by: disposeBag)

        viewModel.isEmpty
            .subscribe(onNext: { [weak self] empty in
                self?.selfView.emptyView.isHidden = !empty
            }).disposed(by: disposeBag)

        viewModel.loading
            .withUnretained(self)
            .subscribe(onNext: { owner, loading in
                print("loading\(loading)")
                owner.selfView.loadingView.isHidden = !loading
                guard let refreshing = owner.selfView.tableView.refreshControl?.isRefreshing else {
                    return
                }
                if refreshing {
                    owner.selfView.loadingView.isHidden = true
                }
            }).disposed(by: disposeBag)
    }
}
