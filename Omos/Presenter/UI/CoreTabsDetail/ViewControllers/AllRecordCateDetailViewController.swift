//
//  AllRecordCateDetailViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/28.
//

import UIKit
import RxSwift
import RxCocoa

class AllRecordCateDetailViewController:BaseViewController {
    
    let selfView = AllRecordCateDetailView()
    var expandedIndexSet : IndexSet = []
    
    var isPaiging = false
    var hasNextPage = false
    
    var cateRecords:[CategoryRespone]?
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
        
        viewModel.selectRecordsShow(type:self.myCateType , page: 0, size: 3, sort: "(\(self.myCateType),ASC)", userid: 1)
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
                self?.cateRecords = data
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
}


extension AllRecordCateDetailViewController:UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cateRecords?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let record = cateRecords?[indexPath.row] else { return UITableViewCell() }
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

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.myCateType {
        case .LYRICS:
            return 100
        case .A_LINE:
            return Constant.mainHeight * 0.63
        default:
            return UITableView.automaticDimension
        }
       
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
