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
        view.searchBar.placeholder = "음악을 검색해주세요"
        view.searchBar.tintColor = .white
        view.searchBar.showsCancelButton = false 
        view.obscuresBackgroundDuringPresentation = false
        return view
    }()
    
    let emptyView = EmptyView()
    let loadingView = LoadingView()
    
    override func configureUI() {
        self.addSubview(emptyView)
        self.addSubview(tableView)
        self.addSubview(loadingView)
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
