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
    var hasNextPage = false
    var currentPage = -1
    var shortCellHeights:[IndexPath:CGFloat] = [:]
    var longCellHeights:[IndexPath:CGFloat] = [:]
    let viewModel:MyDjViewModel
    let user = UserDefaults.standard.integer(forKey: "user")
    var currentDjLastPostId = 0
    var timer: Timer?

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
//        viewModel.fetchMyDjList(userId: Account.currentUser)
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 300, repeats: true, block: {[weak self] (tt) in
            self?.viewModel.fetchMyDjList(userId: Account.currentUser)
            self?.selfView.collectionView.reloadData()
            })
            timer?.fire()
    }
    
    deinit {
        timer?.invalidate()
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
                self?.viewModel.fetchMyDjRecord(userId: Account.currentUser, request: .init(postId: nil, size: 10))
                self?.selfView.collectionView.reloadData()
            }).disposed(by: disposeBag)
      
        viewModel.myDjRecord
            .subscribe(onNext: { [weak self] data in
                if !data.isEmpty {
                    DispatchQueue.main.async { [weak self] in
                        self?.selfView.tableView.reloadData()
                        self?.selfView.tableView.layoutIfNeeded()
                        self?.selfView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                        self?.expandedIndexSet = []
                        self?.expandedIndexSet2 = []
                    }
                }
            }).disposed(by: disposeBag)
        
        viewModel.loading
            .subscribe(onNext: { [weak self] loading in
                self?.selfView.loadingView.isHidden = !loading
            }).disposed(by: disposeBag)
        
        viewModel.isEmpty
            .subscribe(onNext:{ [weak self] empty in
                self?.selfView.emptyView.isHidden = !empty
            }).disposed(by: disposeBag)
    }


    private func fetchRecord() {
    
        viewModel.fetchMyDjRecord(userId: user, request: .init(postId: viewModel.currentMyDjRecord.last?.recordID, size:10))
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

      //계속 부르는 이유 -> 데이터 없어서 게속 스크롤 끝에 가있다고 인지해서 게속부름
//        if offsetY > contentHeight - scrollView.frame.height {
//            if isPaging == false && hasNextPage {
//                beginPaging()
//            }
//        }
    }
}

