//
//  RecordTarget.swift
//  Omos
//
//  Created by sangheon on 2022/03/02.
//

import Foundation
import Alamofire

enum RecordTarget {
    case select
}

extension RecordTarget:TargetType {
    var baseURL: String {
        return "http://ec2-3-37-146-80.ap-northeast-2.compute.amazonaws.com:8080/api/records"
    }
    
    var method: HTTPMethod {
        switch self {
        case .select: return .get

        }
    }
    
    var path: String {
        switch self {
        case .select: return "/select"
        }
    }
    
    var parameters: RequestParams? {
        switch self {
        case .select: return nil

        }
    }
    
    
}
