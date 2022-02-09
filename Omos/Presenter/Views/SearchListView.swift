//
//  SearchListView.swift
//  Omos
//
//  Created by sangheon on 2022/02/09.
//

import UIKit
import SnapKit

class SearchListView:BaseView {
    
    let tableView:UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.separatorStyle = .none
        return table
    }()
    
    let searchViewController:UISearchController = {
        let view = UISearchController(searchResultsController: nil)
        view.searchBar.placeholder = "Enter a company name or symbol"
        view.obscuresBackgroundDuringPresentation = false
        return view
    }()
    
    let emptyView = EmptyView()
    
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
