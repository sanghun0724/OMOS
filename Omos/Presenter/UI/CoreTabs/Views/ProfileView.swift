//
//  ProfileView.swift
//  Omos
//
//  Created by sangheon on 2022/02/07.
//

import UIKit
import SnapKit

class ProfileView:BaseView {
    
    let tableView:UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifier)
       return table
    }()

    
    override func configureUI() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

class ProfileHeaderView:UITableViewHeaderFooterView {
    static let identifier = "ProfileHeaderView"
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
