//
//  Extesion.swift
//  CMC_Hackathon_App
//
//  Created by do_yun on 2022/01/29.
//

import Foundation
import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    // ex. label.textColor = .mainOrange
    class var mainBackgroundColor: UIColor { UIColor(hex: 0xEEEEEE) }
    class var mainViewColor: UIColor {UIColor(hex: 0xFAF9F9)}
    class var mainLikeLabelColor: UIColor {UIColor(hex: 0x858585)}
    class var mainLikeImageColor: UIColor {UIColor(hex: 0xD7D7D7)}
    class var moreButtonColor: UIColor { UIColor(hex: 0x707070) }
    class var yearLabelColor: UIColor {UIColor(hex: 0x8C8C8C)}
    class var lineColor: UIColor {UIColor(hex: 0xC4C4C4)}
    class var mainColor: UIColor {UIColor(hex: 0x404040)}
    class var toggleColor: UIColor {UIColor(hex: 0x636363)}
    
}
