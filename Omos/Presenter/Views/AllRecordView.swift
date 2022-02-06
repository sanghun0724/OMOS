//
//  AllRecordView.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import UIKit
import SnapKit

class AllRecordView:BaseView {
    private let emptyView = EmptyView()
    
    
    private let tableView:UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    //override 되었기 때문에 BaseView에서처럼 ViewdidLoad에 자동 실행
    override func configureUI() {
        
        self.addSubview(emptyView)
        self.addSubview(tableView)
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    
}
