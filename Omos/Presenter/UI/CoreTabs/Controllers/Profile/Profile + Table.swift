//
//  Profile + Table.swift
//  Omos
//
//  Created by sangheon on 2022/02/07.
//

import Foundation
import UIKit

extension ProfileViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MydjProfileHeader.identifier) as! MydjProfileHeader
            //header.configureModel(profile: headerData)
            header.followButton.isHidden = true
            header.settingButton.isHidden = false
            header.settingButton.rx.tap
                .subscribe(onNext: { [weak self] _ in
                   let vc = SettingViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }).disposed(by: header.disposeBag)
            return header
        } else {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: AllRecordHeaderView.identifier) as! AllRecordHeaderView
            if section == 1 {
                header.label.text = "스크랩한 레코드"
            } else {
                header.label.text = "공감한 레코드"
            }
            header.button.setTitle("전체보기", for: .normal)
            header.button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
            header.button.setTitleColor(.mainGrey3, for: .normal)
            header.button.setImage(nil, for: .normal)
            header.button.rx.tap
                .subscribe(onNext: { [weak self] _ in
                    let vc = InteractionRecordViewController()
                    vc.title = header.label.text
                    self?.navigationController?.pushViewController(vc, animated: true)
                }).disposed(by: header.disposeBag)
            
            return header
        }
      

       
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return Constant.mainHeight * 0.17
        } else {
            return Constant.mainHeight * 0.074
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.mainBlack
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section != 0 {
            return Constant.mainHeight * 0.2253
        }
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}