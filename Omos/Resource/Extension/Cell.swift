//
//  Cell.swift
//  Omos
//
//  Created by sangheon on 2022/03/03.
//

import Foundation
import UIKit


extension UITableViewCell {
    
    
    // MARK: 인디케이터 표시
    func showIndicator() {
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
    }
    
    // MARK: 인디케이터 숨김
    @objc func dismissIndicator() {
        IndicatorView.shared.dismiss()
    }
    
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


class IntrinsicTableView: UITableView {
     var intrinsicContentSize2: CGSize {
        let number = numberOfRows(inSection: 0)
        var height: CGFloat = 0
        print("number \(number)")
        for i in 0..<number {
         
            guard let cell = cellForRow(at: IndexPath(row: i, section: 0)) else {
                continue
            }
            height += cell.bounds.height
            print(i)
        }
        return CGSize(width: contentSize.width, height: height)
    }
}
