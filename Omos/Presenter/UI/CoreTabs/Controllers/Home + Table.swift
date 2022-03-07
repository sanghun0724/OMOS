//
//  Home + Table.swift
//  Omos
//
//  Created by sangheon on 2022/03/07.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension HomeViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeHeaderView.identifier) as! HomeHeaderView
        header.notiButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
              print("noti")
            }).disposed(by: header.disposeBag)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.mainHeight * 0.34
    }
    
}
