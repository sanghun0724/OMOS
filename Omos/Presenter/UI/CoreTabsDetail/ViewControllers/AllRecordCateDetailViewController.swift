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
    
    
    override func configureUI() {
        super.configureUI()
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
        //1. 데이터 부르기 페이지+1 해서
        currentPage+=1
        viewModel.selectRecordsShow(type: self.myCateType, page:currentPage , size: 3, sort: "(\(self.myCateType),ASC)", userid: 1)
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


extension AllRecordCateDetailViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return cateRecords.count ?? 0
        } else if section == 1 && isPaging && hasNextPage {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let record = cateRecords[indexPath.row]
            switch self.myCateType {
            case .LYRICS:
                let cell = tableView.dequeueReusableCell(withIdentifier: AllRecordCateShortDetailCell.identifier, for: indexPath) as! AllRecordCateShortDetailCell
                cell.configureModel(record: record)
                cell.selectionStyle = . none
                return cell
            case .A_LINE:
                let cell = tableView.dequeueReusableCell(withIdentifier: AllRecordCateShortDetailCell.identifier, for: indexPath) as! AllRecordCateShortDetailCell
                cell.configureModel(record: record)
                cell.selectionStyle = . none
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: AllRecordCateLongDetailCell.identifier, for: indexPath) as! AllRecordCateLongDetailCell
                
                if expandedIndexSet.contains(indexPath.row) {
                    cell.myView.myView.mainLabelView.numberOfLines = 0
                    cell.myView.myView.mainLabelView.sizeToFit()
                    cell.myView.dummyLabel.text = "접기"
                } else {
                    cell.myView.myView.mainLabelView.numberOfLines = 3
                    cell.myView.myView.mainLabelView.sizeToFit()
                    cell.myView.dummyLabel.text = " 더보기"
                }
                cell.delegate = self
                cell.configureModel(record: record)
                cell.selectionStyle = . none
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.identifier, for: indexPath) as! LoadingCell
            
            cell.start()
            return cell
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            switch self.myCateType {
            case .LYRICS:
                return shortCellHeights[indexPath] ?? 100
            case .A_LINE:
                return shortCellHeights[indexPath] ?? Constant.mainHeight * 0.63
            default:
                print(longCellHeights[indexPath])
                return longCellHeights[indexPath] ?? UITableView.automaticDimension
            }
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.height == 44.0 { return }
        shortCellHeights[indexPath] = cell.height
        longCellHeights[indexPath] = cell.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
}

extension AllRecordCateDetailViewController:MyCellDelegate {
    func readMoreTapped(cell: AllRecordCateLongDetailCell) {
        let indexPath = selfView.tableView.indexPath(for: cell)!
        print(indexPath)
        if(expandedIndexSet.contains(indexPath.row)){
            expandedIndexSet.remove(indexPath.row)
        } else {
            expandedIndexSet.insert(indexPath.row)
        }
        selfView.tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
