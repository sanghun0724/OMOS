//
//  AllRecordViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import SnapKit
import UIKit

class AllRecordViewController: BaseViewController {
    var selectedRecords: SelectResponse?
    let viewModel: AllRecordViewModel

    init(viewModel: AllRecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let selfView = AllRecordView()

    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        viewModel.selectRecordsShow()
        setRightItems()
        setRefreshControl()
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveReloadNotification), name: NSNotification.Name.reload, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    @objc
    func didRecieveReloadNotification() {
        viewModel.selectRecordsShow()
    }

    func setRefreshControl() {
        self.selfView.tableView.refreshControl = UIRefreshControl()
        self.selfView.tableView.refreshControl?.addTarget(self, action: #selector(didPullRefresh), for: .valueChanged)
    }

    func setRightItems() {
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(didTapSearchButton))
        searchButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = searchButton
    }

    @objc
    func didPullRefresh() {
        viewModel.selectRecordsShow()
    }

    @objc
    func didTapSearchButton() {
        let rp = SearchRepositoryImpl(searchAPI: SearchAPI())
        let uc = SearchUseCase(searchRepository: rp)
        let vm = SearchViewModel(usecase: uc)
        let vc = SearchViewController(viewModel: vm, searchType: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func configureUI() {
        view.addSubview(selfView)

        selfView.snp.makeConstraints { make in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    override func bind() {
        viewModel.selectRecords
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.selectedRecords = owner.viewModel.currentSelectRecords
                DispatchQueue.main.async {
                    owner.selfView.tableView.refreshControl?.endRefreshing()
                    owner.selfView.tableView.reloadData()
                }
            }).disposed(by: disposeBag)

        viewModel.loading
            .withUnretained(self)
            .subscribe(onNext: { owner, loading in
                owner.selfView.loadngView.isHidden = !loading
                guard let refreshing = owner.selfView.tableView.refreshControl?.isRefreshing else {
                    return
                }
                if refreshing {
                    owner.selfView.loadngView.isHidden = true
                }
            }).disposed(by: disposeBag)
    }
}

extension AllRecordViewController: AllCollectCellprotocol {
    func collectionView(collectionViewCell: AllRecordCollectionCell?, cate: String, didTappedInTableViewCell: AllRecordTableCell) {
       guard let postId = collectionViewCell?.detailInfo?.recordID,
             let userId = collectionViewCell?.detailInfo?.userID else { return }

        if Account.currentUser == userId {
            let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
            let uc = RecordsUseCase(recordsRepository: rp)
            let vm = MyRecordDetailViewModel(usecase: uc)
            let vc = MyRecordDetailViewController(posetId: postId, viewModel: vm)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
            let uc = RecordsUseCase(recordsRepository: rp)
            let vm = AllRecordDetailViewModel(usecase: uc)
            let vc = AllRecordDetailViewController(viewModel: vm, postId: postId)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
