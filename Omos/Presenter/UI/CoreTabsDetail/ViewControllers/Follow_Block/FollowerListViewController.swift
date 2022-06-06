//
//  FollowerListViewController.swift
//  Omos
//
//  Created by sangheon on 2022/05/29.
//

import UIKit

class FollowerListViewController: BaseListViewController {
    let viewModel: FollowListViewModel
    
    init(viewModel: FollowListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func fetchData() {
        viewModel.fetchFollowerList(userId: Account.currentUser)
    }
    
    override func bind() {
        viewModel.followerList
            .subscribe(onNext: { [weak self] data in
                self?.listTableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    override func dataCount() -> Int {
        viewModel.currentFollowerList.count
    }
    
    override func cellData() -> [ListResponse] {
        viewModel.currentFollowerList
    }
}
