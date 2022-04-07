//
//  MyDJViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import UIKit
import RxSwift
import RxCocoa

class MyDJViewController:BaseViewController , UIScrollViewDelegate {

    let selfView = MydjView()
    var expandedIndexSet : IndexSet = []
    var expandedIndexSet2 : IndexSet = []

    var isPaging = false
    var hasNextPage = true
    var currentPage = -1
    var shortCellHeights:[IndexPath:CGFloat] = [:]
    var longCellHeights:[IndexPath:CGFloat] = [:]
    let viewModel:MyDjViewModel
    let user = UserDefaults.standard.integer(forKey: "user")
    var lastPostId = 0
    var isDjcliked = false 

    init(viewModel:MyDjViewModel) {
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
        selfView.collectionView.delegate = self
        selfView.collectionView.dataSource = self
        viewModel.fetchMyDjList(userId: Account.currentUser)
        viewModel.fetchMyDjRecord(userId: Account.currentUser , request: .init(postId: viewModel.currentMyDjRecord.last?.recordID , size: 6))
//        self.timer = Timer.scheduledTimer(withTimeInterval: 300, repeats: true, block: {[weak self] (tt) in
//            self?.viewModel.fetchMyDjList(userId: Account.currentUser)
//            self?.selfView.collectionView.reloadData()
//            })
//            timer?.fire()
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveFollowNotification), name: NSNotification.Name.follow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveFollowCancelNotification), name: NSNotification.Name.followCancel, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveReloadNotification), name: NSNotification.Name.reload, object: nil)
        

    }
//
//    deinit {
//        timer?.invalidate()
//    }
    
    @objc func didRecieveReloadNotification() {
        isDjcliked = false
        viewModel.fetchMyDjList(userId: Account.currentUser)
        viewModel.fetchMyDjRecord(userId: Account.currentUser, request: .init(postId: viewModel.currentMyDjRecord.last?.recordID, size: 6))
        self.selfView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    @objc func didRecieveFollowCancelNotification(_ notification: Notification) {
        self.viewModel.fetchMyDjList(userId: Account.currentUser)
        self.selfView.collectionView.visibleCells.forEach({ cell in
            if let cell = cell as? MydjCollectionCell {
                cell.djImageView.layer.borderWidth = 0
            }
        })
        isDjcliked = false
        viewModel.fetchMyDjRecord(userId: Account.currentUser, request: .init(postId: viewModel.currentMyDjRecord.last?.recordID, size: 6))
    }
    
    @objc func didRecieveFollowNotification(_ notification: Notification) {
        self.viewModel.fetchMyDjList(userId: Account.currentUser)
        self.selfView.collectionView.visibleCells.forEach({ cell in
            if let cell = cell as? MydjCollectionCell {
                cell.djImageView.layer.borderWidth = 0
            }
        })
        isDjcliked = false
        viewModel.fetchMyDjRecord(userId: Account.currentUser, request: .init(postId: viewModel.currentMyDjRecord.last?.recordID, size: 6))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
       
    }


    override func configureUI() {
        super.configureUI()
        self.view.addSubview(selfView)

        selfView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        selfView.tableView.layoutIfNeeded()
        selfView.tableView.reloadData()
    }


    private func bind() {
        
        viewModel.myDjList
            .subscribe(onNext: { [weak self] data in
                self?.selfView.collectionView.reloadData()
            }).disposed(by: disposeBag)
      
        viewModel.myDjRecord
            .subscribe(onNext: { [weak self] data in
                    self?.hasNextPage = self?.lastPostId == self?.viewModel.currentMyDjRecord.last?.recordID ?? 0 ? false : true
                    self?.lastPostId = self?.viewModel.currentMyDjRecord.last?.recordID ?? 0
                    self?.isPaging = false //페이징 종료
                    self?.selfView.tableView.reloadData()
                    self?.selfView.tableView.layoutIfNeeded()
                    self?.selfView.loadingView.backgroundColor = .clear

            }).disposed(by: disposeBag)
        
        viewModel.userRecords
            .subscribe(onNext: { [weak self] data in
                if !data.isEmpty {
                    DispatchQueue.main.async { [weak self] in
                        self?.selfView.tableView.reloadData()
                        self?.selfView.tableView.layoutIfNeeded()
                        self?.selfView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                        self?.selfView.tableView.layoutIfNeeded()
                        self?.expandedIndexSet = []
                        self?.expandedIndexSet2 = []
                    }
                }
            }).disposed(by:disposeBag)
        
        viewModel.loading
            .subscribe(onNext: { [weak self] loading in
                self?.selfView.loadingView.isHidden = !loading
                print("loading\(loading)")
            }).disposed(by: disposeBag)
        
        viewModel.recordsLoading
            .subscribe(onNext: { [weak self] loading in
                self?.selfView.loadingView.backgroundColor = .mainBackGround
                self?.selfView.loadingView.isHidden = !loading
            }).disposed(by: disposeBag)
        
        viewModel.isEmpty
            .subscribe(onNext:{ [weak self] empty in
                self?.selfView.emptyView.isHidden = !empty
            }).disposed(by: disposeBag)
        
        viewModel.reportState
            .subscribe(onNext: { [weak self] _ in
                self?.selfView.collectionView.visibleCells.forEach({ cell in
                    if let cell = cell as? MydjCollectionCell {
                        cell.djImageView.layer.borderWidth = 0
                    }
                })
                self?.isDjcliked = false
                self?.viewModel.currentMyDjRecord = []
                self?.viewModel.fetchMyDjRecord(userId: Account.currentUser, request: .init(postId: self?.viewModel.currentMyDjRecord.last?.recordID, size: 6))
            }).disposed(by: disposeBag)
    }


    private func fetchRecord() {
        viewModel.fetchMyDjRecord(userId: user, request: .init(postId: viewModel.currentMyDjRecord.last?.recordID, size:6))
        //2. 바인딩 하고 도착하면 데이터 append (위에서 하고 있으니 ok)
    }

    private func beginPaging() {
        isPaging = true

        DispatchQueue.main.async { [weak self]  in
            self?.selfView.tableView.reloadSections(IndexSet(integer: 1), with: .none)
        }

        self.fetchRecord()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        // 스크롤이 테이블 뷰 Offset의 끝에 가게 되면 다음 페이지를 호출
        if offsetY > (contentHeight - height) {
         
            if isPaging == false && hasNextPage && !isDjcliked{
                beginPaging()
            }
        }
    }
}

