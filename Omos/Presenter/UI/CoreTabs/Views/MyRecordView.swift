//
//  MyRecordView.swift
//  Omos
//
//  Created by sangheon on 2022/02/15.
//

import UIKit
//import SnapKit

class MyRecordView:BaseView {
    
    let emptyView = EmptyView()
    let loadingView = LoadingView()
    
    let tableView:UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(MyRecordTableCell.self, forCellReuseIdentifier: MyRecordTableCell.identifier)
        table.backgroundColor = .mainBlack
        table.showsVerticalScrollIndicator = false
        table.automaticallyAdjustsScrollIndicatorInsets = false
        //table.contentInsetAdjustmentBehavior = .never
        //table.insetsContentViewsToSafeArea = false
        return table
    }()
    
    override func configureUI() {
        self.addSubview(tableView)
        self.addSubview(loadingView)
        self.addSubview(emptyView)
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        emptyView.isHidden = true
        loadingView.isHidden = true 
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
