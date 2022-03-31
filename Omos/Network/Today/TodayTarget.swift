//
//  TodayTarget.swift
//  Omos
//
//  Created by sangheon on 2022/03/15.
//

import Foundation
import Alamofire

enum TodayTarget {
  case popuralRecord
  case lovedRecord(userId:Int)
  case recommendDJRecord
  case todayRecord
}

extension TodayTarget:TargetType {
    var baseURL: String {
        return "http://ec2-3-37-146-80.ap-northeast-2.compute.amazonaws.com:8080/api/today"
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .popuralRecord: return "/famous-records-of-today"
        case .lovedRecord(let id): return "/music-loved/\(id)"
        case .recommendDJRecord: return "/recommend-dj"
        case .todayRecord: return "/music-of-today"
        }
    }
    
    var parameters: RequestParams? {
        switch self {
        default:
            return nil
        }
    }
    
    
}
