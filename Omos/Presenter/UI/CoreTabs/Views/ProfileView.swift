//
//  ProfileView.swift
//  Omos
//
//  Created by sangheon on 2022/03/18.
//

import UIKit

class ProfileView:BaseView {
    let tableView:UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        table.register(MydjProfileHeader.self, forHeaderFooterViewReuseIdentifier: MydjProfileHeader.identifier)
        table.register(AllRecordHeaderView.self, forHeaderFooterViewReuseIdentifier: AllRecordHeaderView.identifier)
        table.separatorStyle = .none
        table.backgroundColor = .mainBackGround
        table.showsVerticalScrollIndicator = false
        table.automaticallyAdjustsScrollIndicatorInsets = false
        table.insetsContentViewsToSafeArea = true
        table.contentInsetAdjustmentBehavior = .never
        table.isScrollEnabled = false 
        return table
    }()
    
    
    let loadingView = LoadingView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
    }
    
    override func configureUI() {
        self.addSubview(tableView)
        self.addSubview(loadingView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.isHidden = true 
    }
}
