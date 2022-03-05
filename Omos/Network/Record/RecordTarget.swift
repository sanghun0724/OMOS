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
    case category(cate:cateType,request:CateRequest)
    case myRecord(userid:Int)
    case save(SaveRequest)
}

extension RecordTarget:TargetType {
    var baseURL: String {
        return "http://ec2-3-37-146-80.ap-northeast-2.compute.amazonaws.com:8080/api/records"
    }
    
    var method: HTTPMethod {
        switch self {
        case .select: return .get
        case .category: return .get
        case .myRecord: return .get
        case .save: return .post
        }
    }
    
    var path: String {
        switch self {
        case .select: return "/select"
        case .category(let cate, _): return "/select/category/\(cate)"
        case .myRecord(let user): return "/\(user)"
        case .save: return "/save"
        }
    }
    
    var parameters: RequestParams? {
        switch self {
        case .select: return nil
        case .category(_,let request): return .query(request)
        case .myRecord: return nil
        case .save(let request): return .body(request)
        }
    }
    
    
}
