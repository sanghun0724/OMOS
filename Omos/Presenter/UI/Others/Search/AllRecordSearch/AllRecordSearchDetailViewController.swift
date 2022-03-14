//
//  AllRecordSearchDetailViewController.swift
//  Omos
//
//  Created by sangheon on 2022/03/09.
//

import UIKit
import RxSwift
import RxCocoa

class AllRecordSearchDetailViewController:BaseViewController , UIScrollViewDelegate {

    let selfView = AllRecordCateDetailView()
    var expandedIndexSet : IndexSet = []

    var isPaging = false
    var hasNextPage = false
    var currentPage = -1
    var shortCellHeights:[IndexPath:CGFloat] = [:]
    var longCellHeights:[IndexPath:CGFloat] = [:]
    let viewModel:AllRecordSearchDetailViewModel
    let musicId:String

    init(viewModel:AllRecordSearchDetailViewModel,musicId:String) {
        self.viewModel = viewModel
        self.musicId = musicId
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
        self.tabBarController?.tabBar.isHidden = true
        fetchRecord()
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
        viewModel.oneMusicRecords
            .subscribe(onNext:{ [weak self] data in
                self?.hasNextPage = self?.viewModel.currentOneMusicRecords.count ?? 0 > 300 ? false : true //다음페이지 있는지 확인
                self?.isPaging = false //페이징 종료
                self?.selfView.tableView.reloadData()
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
    
        viewModel.oneMusicRecordsFetch(musicId: self.musicId, request: .init(postId: viewModel.currentOneMusicRecords.last?.recordID, size: 10, userId: UserDefaults.standard.integer(forKey: "user"),sortType: "like"))
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

