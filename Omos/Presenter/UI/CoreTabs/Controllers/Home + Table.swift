//
//  Home + Table.swift
//  Omos
//
//  Created by sangheon on 2022/03/07.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension HomeViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            return UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: AllRecordTableCell.identifier,for:indexPath) as! AllRecordTableCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableMiddleCell.identifier,for:indexPath) as! HomeTableMiddleCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableLastCell.identifier,for:indexPath) as! HomeTableLastCell
            return cell
        default:
            print("de other")
        }
      
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: AllRecordHeaderView.identifier) as! AllRecordHeaderView
        header.button.isHidden = true
        switch section {
        case 0:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeHeaderView.identifier) as! HomeHeaderView
            header.notiButton.rx.tap
                .asDriver()
                .drive(onNext: { [weak self] _ in
                  print("noti")
                }).disposed(by: header.disposeBag)
            return header
        case 1:
            header.label.text = "지금 인기있는 레코드"
            return header
        case 2:
            header.label.text = "OMOS 추천 DJ"
            return header
        case 3:
            header.label.text = "내가 사랑했던 노래"
            return header
        default:
            print("de other")
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 0
        case 1:
            return Constant.mainHeight / 4.72
        case 2:
            return Constant.mainHeight * 0.1478
        case 3:
            return Constant.mainHeight * 0.201
        default:
            print("de other")
        }
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.mainBackGround
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.white
    }
  
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return Constant.mainHeight * 0.34
        } else {
            return Constant.mainHeight / 17
        }
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       if indexPath.section == 3 {
           print("hi")
        }
    }
    
}
