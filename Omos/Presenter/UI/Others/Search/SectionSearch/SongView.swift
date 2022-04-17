//
//  SongView.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.
//

import Foundation
import UIKit

class SongView: BaseView {
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SongTableCell.self, forCellReuseIdentifier: SongTableCell.identifier)
        table.register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.identifier)
        table.separatorStyle = .none
        table.backgroundColor = .mainBlack
        table.showsVerticalScrollIndicator = false
        table.automaticallyAdjustsScrollIndicatorInsets = false
        return table
    }()

    let loadingView = LoadingView()
    let emptyView = EmptyView()

    override func configureUI() {
        super.configureUI()
        self.addSubview(tableView)
        self.addSubview(loadingView)
        self.addSubview(emptyView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        emptyView.isHidden = true
        loadingView.isHidden = true
    }
}
