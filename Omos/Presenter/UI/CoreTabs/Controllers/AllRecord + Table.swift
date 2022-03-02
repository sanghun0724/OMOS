//
//  AllRecord + Table.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import Foundation
import UIKit
import RxSwift


extension AllRecordViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberofRows()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllRecordTableCell.identifier,for:indexPath) as! AllRecordTableCell
        guard let model = self.selectedRecords else { return  AllRecordTableCell() }
        switch indexPath.row {
        case 0:
            cell.configureModel(records: model.aLine)
        case 1:
            cell.configureModel(records: model.ost)
        case 2:
            cell.configureModel(records: model.free)
        case 3:
            cell.configureModel(records: model.aLine)
        case 4:
            cell.configureModel(records: model.aLine)
        default:
            print("default")
        }
        cell.cellDelegate = self 
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: AllRecordHeaderView.identifier) as! AllRecordHeaderView
        headerView.button.rx.tap.asDriver()
            .drive(onNext: { [weak self] in
                print("click is here ")
            }).disposed(by: headerView.disposeBag)
        switch section {
        case 0:
            headerView.label.text = "나만의 가사해석"
        case 1:
            headerView.label.text = "내인생의 OST"
        case 2:
            headerView.label.text = "노래속 나의 이야기"
        case 3:
            headerView.label.text = "어떤 카테코리 등등"
        case 4:
            headerView.label.text = "테스트 입니다"
        default:
            print("you need to add section case")
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.mainBackGround
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 4.72
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.height / 17
    }
    
    
}
