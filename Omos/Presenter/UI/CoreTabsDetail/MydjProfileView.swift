//
//  MydjProfileView.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.
//

import Foundation
import UIKit

class MydjProfieView:BaseView {
    
    let tableView:UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifier)
        table.backgroundColor = .mainBackGround
       return table
    }()

    
    override func configureUI() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}


class MydjProfileHeader:UITableViewHeaderFooterView {
    
    let profileImageView:UIImageView = {
        let view = UIImageView(image:UIImage(named: "albumCover"))
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let profileLabel:UILabel = {
       let label = UILabel()
        label.text = "dj 닉네임두자닉네임두자"
        return label
    }()
    
    let followButton:UIButton = {
        let button = UIButton()
        return button
    }()
    
    let recordTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "레코드"
        return label
    }()
    
    let recordCountLabel:UILabel = {
        let label = UILabel()
        label.text = "0000"
        return label
    }()
    
    let followerTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "팔로워"
        return label
    }()
    
    let followerCountLabel:UILabel = {
        let label = UILabel()
        label.text = "0000"
        return label
    }()
    
    let followingTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "팔로잉"
        return label
    }()
    
    let followingCountLabel:UILabel = {
        let label = UILabel()
        label.text = "0000"
        return label
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
    }
    
    func configureUI() {
        
    }
}
