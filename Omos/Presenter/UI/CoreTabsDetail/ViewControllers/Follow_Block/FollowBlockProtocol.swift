//
//  FollowBlockProtocol.swift
//  Omos
//
//  Created by sangheon on 2022/06/10.
//

import Foundation
import UIKit

//DecoratorBase
protocol FollowBlockBaseProtocol {
    func binding(listTableView:UITableView)
    func bindingCell(cell: FollowBlockListCell)
    func fetchData()
    func configureData()
    func dataCount() -> Int
    func cellData() -> [ListResponse]
}
