//
//  ArtistView.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.
//

import UIKit

class ArtistView:BaseView {
    
    let tableView:UITableView = {
        let table = UITableView(frame: .zero, style: .grouped) //stick header 해제 
        table.register(ArtistTableCell.self, forCellReuseIdentifier: ArtistTableCell.identifier)
        table.separatorStyle = .none
        table.backgroundColor = .mainBlack
        table.showsVerticalScrollIndicator = false
        table.automaticallyAdjustsScrollIndicatorInsets = false
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
