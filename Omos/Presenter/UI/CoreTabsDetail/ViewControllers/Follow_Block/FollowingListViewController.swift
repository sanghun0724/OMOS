//
//  FollowingListViewController.swift
//  Omos
//
//  Created by sangheon on 2022/05/29.
//

import UIKit
import RxCocoa
import RxSwift

class FollowingListViewController: BaseViewController, FollowBlockBaseProtocol {
    let viewModel: FollowListViewModel
    
    init(viewModel: FollowListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func fetchData() {
        viewModel.fetchFollowingList(userId: Account.currentUser)
    }
    
    func binding(listTableView: UITableView) {
        viewModel.followingList
            .subscribe(onNext: { [weak self] _ in
                listTableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    func configureData() {
        
    }
    
     func bindingCell(cell:FollowBlockListCell) {
        cell.listButton.setTitle("팔로잉", for: .normal)
    }
    
     func dataCount() -> Int {
        viewModel.currentFollowingList.count
    }
    
     func cellData() -> [ListResponse] {
        viewModel.currentFollowingList
    }
    
}
