//
//  FollowerListViewController.swift
//  Omos
//
//  Created by sangheon on 2022/05/29.
//

import RxSwift
import UIKit

class FollowerListViewController: FollowBlockBaseProtocol {
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
        viewModel.fetchFollowerList(userId: Account.currentUser)
    }
    
    func binding(listTableView: UITableView) {
        viewModel.followerList
            .subscribe(onNext: { _ in
                listTableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    func bindingCell(cell: FollowBlockListCell, data: ListResponse ,index: IndexPath) {
        cell.listButton.rx.tap
            .asDriver()
            .throttle(.seconds(1))
            .drive(onNext: { [weak self] _ in
                if cell.listButton.layer.borderWidth == 0 {
                    self?.cellIndexDict.removeValue(forKey: index)
                    cell.listButton.layer.borderWidth = 1
                    cell.listButton.backgroundColor = .clear
                    cell.listButton.setTitleColor(UIColor.mainGrey4, for: .normal )
                } else {
                    self?.cellIndexDict[index] = data.userID
                    cell.listButton.layer.borderWidth = 0
                    cell.listButton.backgroundColor = .mainOrange
                    cell.listButton.setTitleColor(UIColor.white, for: .normal )
                }
            }).disposed(by: cell.disposeBag)
    }
    
    func dataCount() -> Int {
        viewModel.currentFollowerList.count
    }
    
    func cellData() -> [ListResponse] {
        viewModel.currentFollowerList
    }
    
    func callAction() {
        for dicVal in cellIndexDict {
            viewModel.deleteFollow(fromId: dicVal.value, toId: Account.currentUser) // 팔로워를 없애는거니 id 바꿔서 넣어주면 됨 
        }
        NotificationCenter.default.post(name: NSNotification.Name.follow, object: nil, userInfo: nil)
    }
    
}
