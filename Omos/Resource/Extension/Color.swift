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
    class var mainBackGround: UIColor { UIColor(hex: 0x212121) }
    class var mainBlack: UIColor { UIColor(hex: 0x1A1A1A) }
    class var mainBlack1: UIColor { UIColor(hex: 0x3A3A3C) }
    class var mainOrange: UIColor { UIColor(hex: 0xD35E32) }
    class var mainGrey: UIColor { UIColor(hex: 0x636363) }
    class var mainGrey4: UIColor { UIColor(hex: 0xAEAEB2) }
    class var mainGrey5: UIColor { UIColor(hex: 0x8E8E93) }
    class var mainGrey7: UIColor { UIColor(hex: 0x48484A) }
    class var buttonLabel: UIColor { UIColor(hex: 0x341F20) }
    class var kakaoYellow: UIColor { UIColor(hex: 0xFEE500) }
    class var mainGrey1: UIColor { UIColor(hex: 0xE5E5EA) }
    class var mainGrey3: UIColor { UIColor(hex: 0xC7C7CC) }
    class var mainGrey6: UIColor { UIColor(hex: 0x8E8E93) }
    class var mainBlack2: UIColor { UIColor(hex: 0x2C2C2E) }
    class var mainGrey8: UIColor { UIColor(hex: 0x48484A) }
    class var LyricsBack: UIColor { UIColor(hex: 0x29292A) }

    class var mainLikeLabelColor: UIColor { UIColor(hex: 0x858585) }
    class var mainLikeImageColor: UIColor { UIColor(hex: 0xD7D7D7) }
    class var moreButtonColor: UIColor { UIColor(hex: 0x707070) }
    class var yearLabelColor: UIColor { UIColor(hex: 0x8C8C8C) }
    class var lineColor: UIColor { UIColor(hex: 0xC4C4C4) }
    class var mainColor: UIColor { UIColor(hex: 0x404040) }
    class var toggleColor: UIColor { UIColor(hex: 0x636363) }
}
