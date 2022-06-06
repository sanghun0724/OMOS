//
//  FollowingListViewController.swift
//  Omos
//
//  Created by sangheon on 2022/05/29.
//

import UIKit

class BlockListViewController: BaseListViewController {
    let viewModel: FollowListViewModel
    
    init(viewModel: FollowListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func fetchData() {
        viewModel.fetchBlockList(userId: Account.currentUser)
    }
    
    override func bind() {
        viewModel.blockList
            .subscribe(onNext: { [weak self] _ in
                self?.listTableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    override func dataCount() -> Int {
        viewModel.currentBlockList.count
    }
    
    override func cellData() -> [ListResponse] {
        viewModel.currentBlockList
    }
}
