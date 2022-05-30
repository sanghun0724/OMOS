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
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        configureUI()
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
        
    }
    
    func fetchData() { //프로토콜 하나 만들까.. 이렇게 할까 고민 (추상 메소드)
        assertionFailure("This method must be overridden")
    }
    
}

extension BaseListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FollowBlockListCell.identifier) as? FollowBlockListCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}
