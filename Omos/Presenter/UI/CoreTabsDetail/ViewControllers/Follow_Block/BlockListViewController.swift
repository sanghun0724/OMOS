//
//  FollowingListViewController.swift
//  Omos
//
//  Created by sangheon on 2022/05/29.
//

import UIKit

class BlockListViewController: BaseViewController, FollowBlockBaseProtocol {
    let viewModel: FollowListViewModel
    
    init(viewModel: FollowListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchData() {
        viewModel.fetchBlockList(userId: Account.currentUser)
    }
    
    func bindingCell(cell:FollowBlockListCell) {
        
    }
    
    func configureData() {
        
    }
    
    func dataCount() -> Int {
        viewModel.currentBlockList.count
    }
    
    func cellData() -> [ListResponse] {
        viewModel.currentBlockList
    }
   
   func binding(listTableView: UITableView) {
       viewModel.blockList
           .subscribe(onNext: { [weak self] _ in
               listTableView.reloadData()
           }).disposed(by: disposeBag)
   }
   
}
