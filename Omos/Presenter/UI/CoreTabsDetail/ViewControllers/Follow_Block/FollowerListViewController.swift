//
//  FollowerListViewController.swift
//  Omos
//
//  Created by sangheon on 2022/05/29.
//

import RxSwift
import UIKit

class FollowerListViewController: BaseViewController, FollowBlockBaseProtocol {
    let viewModel: FollowListViewModel
    
    init(viewModel: FollowListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchData() {
        viewModel.fetchFollowerList(userId: Account.currentUser)
    }
    
    func binding(listTableView:UITableView) {
        viewModel.followerList
            .subscribe(onNext: { [weak self] _ in
                listTableView.reloadData()
                print("test")
            }).disposed(by: disposeBag)
    }
    
    func configureData() {
        
    }
    
    func bindingCell(cell:FollowBlockListCell) {
        print("차단")
    }
    
    func dataCount() -> Int {
        viewModel.currentFollowerList.count
    }
    
    func cellData() -> [ListResponse] {
        viewModel.currentFollowerList
    }
}
