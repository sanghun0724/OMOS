//
//  Date.swift
//  CMC_Hackathon_App
//
//  Created by do_yun on 2022/01/29.
//

import Foundation

private let dateFormatter: DateFormatter = {
    let format = DateFormatter()
    format.locale = Locale(identifier: "ko_kr")
    return format
}()

extension Date {
    var dateString: String {
        dateFormatter.dateFormat = "M월 d일"
        return dateFormatter.string(from: self)
    }
    var timeString: String {
        dateFormatter.dateFormat = "a HH:mm"
        return dateFormatter.string(from: self)
    }
    var dateTimeString: String {
        dateFormatter.dateFormat = "d일 a HH시"
        return dateFormatter.string(from: self)
    }
    static var currentTimeStamp: Int64 {
            Int64(Date().timeIntervalSince1970 * 1_000)
        }
}
