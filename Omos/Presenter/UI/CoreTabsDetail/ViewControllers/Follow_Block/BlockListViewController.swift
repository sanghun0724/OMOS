//
//  FollowingListViewController.swift
//  Omos
//
//  Created by sangheon on 2022/05/29.
//

import UIKit
import RxSwift

class BlockListViewController: FollowBlockBaseProtocol {
    var cellIndexDict: [ IndexPath : Int] = [:]
    let viewModel: FollowListViewModel
    let disposeBag = DisposeBag()
    
    init(viewModel: FollowListViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchData() {
        viewModel.fetchBlockList(userId: Account.currentUser)
    }
    
    func bindingCell(cell: FollowBlockListCell, data: ListResponse, index: IndexPath) {
        setListButtonUI(cell)
        cell.listButton.rx.tap
            .asDriver()
            .throttle(.seconds(1))
            .drive(onNext: { [weak self] _ in
                if cell.listButton.layer.borderWidth == 0 {
                    let action = UIAlertAction(title: "차단 해제", style: .default) { _ in
                        self?.cellIndexDict[index] = data.userID
                        cell.listButton.layer.borderWidth = 1
                        cell.listButton.backgroundColor = .clear
                        cell.listButton.setTitleColor(UIColor.mainGrey4, for: .normal )
                        cell.listButton.setTitle("차단", for: .normal)
                    }
                    action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
                    self?.setTopController().presentAlert(title: "", with: action, message: "\((cell.nicknameLabel.text)!)님을 차단 해제하시겠어요??", isCancelActionIncluded: true, preferredStyle: .alert)
                } else {
                    self?.cellIndexDict.removeValue(forKey: index)
                    cell.listButton.layer.borderWidth = 0
                    cell.listButton.backgroundColor = .mainOrange
                    cell.listButton.setTitleColor(UIColor.white, for: .normal )
                    cell.listButton.setTitle("차단 해제", for: .normal)
                }
            }).disposed(by: cell.disposeBag)
    }
    
    private func setTopController() -> UIViewController {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return UIViewController()
    }
    
    private func setListButtonUI (_ cell: FollowBlockListCell) {
        cell.listButton.setTitle("차단 해제", for: .normal)
        cell.listButton.backgroundColor = .mainOrange
        cell.listButton.layer.borderWidth = 0
        cell.listButton.setTitleColor(.white, for: .normal)
    }
    
    func dataCount() -> Int {
        viewModel.currentBlockList.count
    }
    
    func cellData() -> [ListResponse] {
        viewModel.currentBlockList
    }
    
    func binding(listTableView: UITableView) {
        viewModel.blockList
            .subscribe(onNext: { _ in
                listTableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    func callAction() {
        for dicVal in cellIndexDict {
            viewModel.deleteBlock(targetId: dicVal.value)
        }
    }
    
}
