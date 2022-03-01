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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        
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
}


extension AllRecordCateDetailViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllRecordCateDetailCell.identifier, for: indexPath) as! AllRecordCateDetailCell
        if expandedIndexSet.contains(indexPath.row) {
                cell.myView.myView.mainLabelView.numberOfLines = 0
                cell.myView.myView.mainLabelView.sizeToFit()
           } else {
                cell.myView.myView.mainLabelView.numberOfLines = 3
                cell.myView.myView.mainLabelView.sizeToFit()
           }

        cell.delegate = self
        cell.selectionStyle = . none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
}

extension AllRecordCateDetailViewController:MyCellDelegate {
    func readMoreTapped(cell: AllRecordCateDetailCell) {
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
