//
//  SearchAlbumDetailView.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.
//

import UIKit

class SearchAlbumDetailView:BaseView {
    
    let tableView:UITableView = {
        let table = UITableView()
        table.register(SongTableCell.self, forCellReuseIdentifier: SongTableCell.identifier)
        table.register(AlbumTableCell.self, forCellReuseIdentifier: AlbumTableCell.identifier)
        table.register(ArtistTableCell.self, forCellReuseIdentifier: ArtistTableCell.identifier)
        table.register(AllRecordHeaderView.self, forHeaderFooterViewReuseIdentifier: AllRecordHeaderView.identifier)
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
