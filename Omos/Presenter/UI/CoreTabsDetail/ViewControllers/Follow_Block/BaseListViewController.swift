//
//  BaseFollowViewController.swift
//  Omos
//
//  Created by sangheon on 2022/05/29.
//

import UIKit

class BaseListViewController: BaseViewController {
    let listTableView: UITableView = {
        let table = UITableView()
        table.register(FollowBlockListCell.self, forCellReuseIdentifier: FollowBlockListCell.identifier)
        table.backgroundColor = .mainBackGround
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        configureUI()
        fetchData()
    }
    
    override func configureUI() {
        super.configureUI()
        view.addSubview(listTableView)
    
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func bind() {
        assertionFailure("This method must be overridden")
    }
    
    func fetchData() { // 프로토콜 하나 만들까.. 이렇게 할까 고민 (추상 메소드)
        assertionFailure("This method must be overridden")
    }
    
    func configureData() {
        assertionFailure("This method must be overridden")
    }
    
    func dataCount() -> Int {
        0
    }
    
    func cellData() -> [ListResponse] {
        []
    }
}

extension BaseListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FollowBlockListCell.identifier) as? FollowBlockListCell else {
            return UITableViewCell()
        }
        guard let data = cellData()[safe:indexPath.row] else { return UITableViewCell() }
        cell.configure(data: data)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constant.mainHeight * 0.094
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
