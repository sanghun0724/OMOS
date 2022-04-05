//
//  Constant.swift
//  Omos
//
//  Created by sangheon on 2022/02/11.
//

import Foundation
import UIKit

struct Constant {
   static let loginCorner = 4.0
   static let LoginTopViewHeight = 0.6
   static let mainHeight = UIScreen.main.bounds.height
   static let mainWidth = UIScreen.main.bounds.width
}

struct Account {
   static var currentUser = UserDefaults.standard.integer(forKey: "user")
   static var currentReportRecordsId: [Int] {
        get {
            return UserDefaults.standard.array(forKey: "report") as? [Int] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "report")
        }
    }
}
