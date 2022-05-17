//
//  CellConfigurator.swift
//  Omos
//
//  Created by sangheon on 2022/05/17.
//

import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    func configure(data: DataType)
}

protocol CellConfigurator {
    static var reuseId:String { get }
    func confiure(cell: UIView)
}

class TableCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator where CellType.DataType == DataType, CellType: UITableViewCell {
    static var reuseId: String { return "\(CellType.self)"}
    
    let item:DataType
    
    init(item:DataType) {
        self.item = item
    }
    
    func confiure(cell: UIView) {
        (cell as! CellType).configure(data: item)
    }
}
