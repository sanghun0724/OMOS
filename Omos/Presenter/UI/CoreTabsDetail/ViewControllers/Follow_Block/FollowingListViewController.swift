//
//  FollowingListViewController.swift
//  Omos
//
//  Created by sangheon on 2022/05/29.
//

import UIKit
import RxCocoa
import RxSwift

class FollowingListViewController: FollowBlockBaseProtocol {
    var cellIndexDict: [IndexPath : Int] = [:]
    let viewModel: FollowListViewModel
    let disposeBag = DisposeBag()
    
    init(viewModel: FollowListViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func fetchData() {
        viewModel.fetchFollowingList(userId: Account.currentUser)
    }
    
    func binding(listTableView: UITableView) {
        viewModel.followingList
            .subscribe(onNext: { _ in
                listTableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    func bindingCell(cell: FollowBlockListCell, data: ListResponse, index: IndexPath) {
         cell.listButton.setTitle("팔로잉", for: .normal)
         cell.listButton.rx.tap
             .asDriver()
             .throttle(.seconds(1))
             .drive(onNext: { [weak self] _ in
                 if cell.listButton.layer.borderWidth == 0 {
                     self?.cellIndexDict.removeValue(forKey: index)
                     cell.listButton.layer.borderWidth = 1
                     cell.listButton.backgroundColor = .clear
                     cell.listButton.setTitleColor(UIColor.mainGrey4, for: .normal )
                     cell.listButton.setTitle("팔로잉", for: .normal)
                 } else {
                     self?.cellIndexDict[index] = data.userID
                     cell.listButton.layer.borderWidth = 0
                     cell.listButton.backgroundColor = .mainOrange
                     cell.listButton.setTitleColor(UIColor.white, for: .normal )
                     cell.listButton.setTitle("팔로우", for: .normal)
                 }
             }).disposed(by: cell.disposeBag)
    }
    
     func dataCount() -> Int {
        viewModel.currentFollowingList.count
    }
    
     func cellData() -> [ListResponse] {
        viewModel.currentFollowingList
    }
    
    func callAction() {
        for dicVal in cellIndexDict {
            viewModel.deleteFollow(fromId: Account.currentUser, toId: dicVal.value)
        }
        NotificationCenter.default.post(name: NSNotification.Name.followCancel, object: nil, userInfo: nil)
    }
    
}
