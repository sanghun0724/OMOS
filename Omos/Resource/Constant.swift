//
//  Constant.swift
//  Omos
//
//  Created by sangheon on 2022/02/11.
//

import Foundation
import UIKit

struct Account {
   static var currentUser = UserDefaults.standard.integer(forKey: "user")
   static var currentReportRecordsId: [Int] {
        get {
            UserDefaults.standard.array(forKey: "report") as? [Int] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "report")
        }
    }
}

struct RestApiUrl {
#if DEBUG
    static let restUrl = "http://ec2-3-39-121-23.ap-northeast-2.compute.amazonaws.com:8080/api"
#else
    static let restUrl = "http://ec2-3-39-121-23.ap-northeast-2.compute.amazonaws.com:8080/api"
#endif
}

struct Constant {
   static let loginCorner = 4.0
   static let LoginTopViewHeight = 0.6
   static let mainHeight = UIScreen.main.bounds.height
   static let mainWidth = UIScreen.main.bounds.width
    static var statuBarHeight: CGFloat = 0.0
}
