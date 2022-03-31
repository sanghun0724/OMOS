//
//  AllRecordCateDetailView.swift
//  Omos
//
//  Created by sangheon on 2022/02/28.
//

import UIKit
import ReadMoreTextView

class AllRecordCateDetailView:BaseView {
    
    let tableView:UITableView = {
       let table = UITableView()
        table.register(AllRecordCateLongDetailCell.self, forCellReuseIdentifier: AllRecordCateLongDetailCell.identifier)
        table.register(AllRecordCateShortDetailCell.self, forCellReuseIdentifier: AllRecordCateShortDetailCell.identifier)
        table.register(AllrecordLyricsTableCell.self, forCellReuseIdentifier: AllrecordLyricsTableCell.identifier)
        table.register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.identifier)
        table.backgroundColor = .mainBackGround
        table.estimatedRowHeight = 500
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.automaticallyAdjustsScrollIndicatorInsets = false
       return table
    }()
    let emptyView = EmptyView()
    let loadingView = LoadingView()
    
    override func configureUI() {
        self.addSubview(tableView)
        self.addSubview(emptyView)
        self.addSubview(loadingView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loadingView.backgroundColor = .clear
    }
}
