//
//  SongView.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.
//

import Foundation
import UIKit

class SongView:BaseView {
    
    let tableView:UITableView = {
        let table = UITableView()
        table.register(SongTableCell.self, forCellReuseIdentifier: SongTableCell.identifier)
        table.separatorStyle = .none
        return table
    }()
    
    override func configureUI() {
        super.configureUI()
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
