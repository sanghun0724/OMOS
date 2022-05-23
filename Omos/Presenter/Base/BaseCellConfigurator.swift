//
//  CellConfigurator.swift
//  Omos
//
//  Created by sangheon on 2022/05/17.
//

import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    func configure(record: DataType)
    func cellHelper()
}

protocol CellConfigurator {
    static var reuseId: String { get }
    func configure(cell: UIView, _ hasSet: Bool)
}

protocol ExpandableCellProtocol {
    func shrinkCell(_ hasSet: Bool)
}

class TableCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator where CellType.DataType == DataType, CellType: UITableViewCell {
    static var reuseId: String { return String(describing: CellType.self) }
    
    let item: DataType
    
    init(item: DataType) {
        self.item = item
    }
    
    func configure(cell: UIView, _ hasSet: Bool) {
        let cellType = (cell as! CellType)
        cellType.configure(record: item)
        cellType.cellHelper()
        if let expandCell = cell as? ExpandableCellProtocol {
            expandCell.shrinkCell(hasSet)
        }
    }
}
