//
//  MyRecordView.swift
//  Omos
//
//  Created by sangheon on 2022/02/15.
//

import UIKit

class MyRecordView: BaseView {
    let emptyView = EmptyView()
    let loadingView = LoadingView()

    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(MyRecordTableCell.self, forCellReuseIdentifier: MyRecordTableCell.identifier)
        table.backgroundColor = .mainBlack
        table.showsVerticalScrollIndicator = false
        table.automaticallyAdjustsScrollIndicatorInsets = false
        return table
    }()

    override func configureUI() {
        self.addSubview(tableView)
        self.addSubview(loadingView)
        self.addSubview(emptyView)
        emptyView.isHidden = true
        loadingView.isHidden = true

        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.contentSize.width, height: CGFloat.leastNormalMagnitude))
    }
}
