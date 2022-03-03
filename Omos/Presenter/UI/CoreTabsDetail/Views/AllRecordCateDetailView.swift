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
        table.backgroundColor = .mainBackGround
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = UITableView.automaticDimension
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.automaticallyAdjustsScrollIndicatorInsets = false
       return table
    }()

    
    override func configureUI() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
