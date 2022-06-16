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
    var cellIndexDict:[IndexPath:Int] { get set }
    func binding(listTableView: UITableView)
    func bindingCell(cell: FollowBlockListCell, data: ListResponse, index: IndexPath)
    func fetchData()
    func dataCount() -> Int
    func cellData() -> [ListResponse]
    func callAction()
}
