//
//  AllRecord + Table.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import Foundation
import UIKit


extension AllRecordViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberofSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllRecordTableCell.identifier,for:indexPath) as! AllRecordTableCell
        cell.backgroundColor = .orange
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: AllRecordHeaderView.identifier) as! AllRecordHeaderView
        headerView.button.rx.tap
            .subscribe(onNext: {
                print("click")
            }).disposed(by: disposeBag)
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
        view.tintColor = .mainGrey
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
}
