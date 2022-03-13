//
//  MydjProfile + Table.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.
//

import Foundation
import UIKit
import KakaoSDKUser


extension MydjProfileViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyRecordTableCell.identifier, for: indexPath) as! MyRecordTableCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MydjProfileHeader.identifier) as! MydjProfileHeader
        guard let headerData = viewModel.currentMydjProfile else { return UITableViewHeaderFooterView() }
        header.configureModel(profile: headerData)
        header.followButton.rx.tap
            .asDriver()
            .drive(onNext:{ [weak self] _ in
                if header.followButton.layer.borderWidth == 0 {
                    self?.viewModel.saveFollow(fromId: self?.fromId ?? 0, toId: self?.toId ?? 0)
                    header.followButton.layer.borderWidth = 1
                    header.followButton.backgroundColor = .clear
                    header.followButton.setTitleColor(UIColor.mainGrey4, for: .normal )
                    header.followButton.setTitle("팔로잉", for: .normal)
                } else {
                    self?.viewModel.deleteFollow(fromId: self?.fromId ?? 0, toId: self?.toId ?? 0)
                    header.followButton.layer.borderWidth = 0
                    header.followButton.backgroundColor = .mainOrange
                    header.followButton.setTitleColor(UIColor.white, for: .normal )
                    header.followButton.setTitle("팔로우", for: .normal)
                }
            }).disposed(by: header.disposeBag)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.mainHeight * 0.17
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.mainBlack
        
    }
}

