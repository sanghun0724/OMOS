//
//  ProfileViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import RxSwift
import UIKit

class ProfileViewController: BaseViewController {
    private let selfView = ProfileView()
    let viewModel: ProfileViewModel

    init(viewModel: ProfileViewModel) {
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
        print("this is profile \(Account.currentUser)")
        viewModel.allFetch()
        setRefreshControl()
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveProfileReloadNotification), name: NSNotification.Name.follow, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backgroundColor = .mainBlack
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.backgroundColor = .mainBackGround
    }

    @objc func didRecieveProfileReloadNotification() {
        viewModel.allFetch()
    }

    @objc func didPullRefresh() {
        viewModel.allFetch()
    }

    func setRefreshControl() {
        self.selfView.tableView.refreshControl = UIRefreshControl()
        self.selfView.tableView.refreshControl?.addTarget(self, action: #selector(didPullRefresh), for: .valueChanged)
    }

    override func configureUI() {
        self.view.backgroundColor = .mainBlack
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        view.addSubview(selfView)
        selfView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    func bind() {
        viewModel.allLoading
            .subscribe(onNext: { [weak self] loading in
                print(loading)
                self?.selfView.loadingView.isHidden = !loading
                guard let refreshing = self?.selfView.tableView.refreshControl?.isRefreshing else {
                    return
                }
                if refreshing {
                    self?.selfView.loadingView.isHidden = true
                }
            }).disposed(by: disposeBag)

        Observable.zip(viewModel.myProfileRecord, viewModel.myProfile)
        .subscribe(onNext: { [weak self] _ in
            DispatchQueue.main.async {
                self?.selfView.tableView.refreshControl?.endRefreshing()
                self?.selfView.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
}
