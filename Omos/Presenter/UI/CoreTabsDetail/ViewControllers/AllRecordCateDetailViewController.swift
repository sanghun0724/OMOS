//
//  AllRecordCateDetailViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/28.
//

import UIKit
import RxSwift
import RxCocoa

class AllRecordCateDetailViewController:BaseViewController , UIScrollViewDelegate {
    
    let selfView = AllRecordCateDetailView()
    var expandedIndexSet : IndexSet = []
    
    var isPaging = false
    var hasNextPage = false
    var currentPage = -1
    var shortCellHeights:[IndexPath:CGFloat] = [:]
    var longCellHeights:[IndexPath:CGFloat] = [:]
    
    var cateRecords:[CategoryRespone] = []
    let viewModel:AllRecordCateDetailViewModel
    let myCateType:cateType
    
    init(viewModel:AllRecordCateDetailViewModel,cateType:cateType) {
        self.viewModel = viewModel
        self.myCateType = cateType
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
        fetchRecord()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func configureUI() {
        super.configureUI()
        selfView.emptyView.isHidden = true 
        setTitle()
        self.view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        selfView.tableView.layoutIfNeeded()
        selfView.tableView.reloadData()
    }
    
    
    private func bind() {
        viewModel.cateRecords
            .subscribe(onNext:{ [weak self] data in
                self?.cateRecords += data
                self?.hasNextPage = self?.cateRecords.count ?? 0 > 300 ? false : true //다음페이지 있는지 확인
                self?.isPaging = false //페이징 종료
                self?.selfView.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel.loading
            .subscribe(onNext: { [weak self] loading in
                self?.selfView.loadingView.isHidden = !loading
            }).disposed(by: disposeBag)
        
        
    }
    
    private func setTitle() {
        let label = UILabel()
        switch self.myCateType {
        case .A_LINE:
            label.text = "한 줄 감상"
        case .LYRICS:
            label.text = "나만의 가사해석"
        case .STORY:
            label.text = "노래 속 나의 이야기"
        case .FREE:
            label.text = "자유 공간"
        case .OST:
            label.text = "내 인생의 OST"
        default:
            fatalError()
        }
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.tintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }
    
    private func fetchRecord() {
        //1. 데이터 부르기 마지막 포스트아이디
        
        viewModel.selectRecordsShow(type: self.myCateType, postId:viewModel.currentCateRecords.last?.recordID , size: 3, sort: "like", userid: UserDefaults.standard.integer(forKey: "user"))
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
