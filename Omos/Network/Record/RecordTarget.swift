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
    case searchRecord(musicId:String,SearchRecordRequest)
    case recordIspublic(postId:Int)
    case recordDelete(postId:Int)
    case recordUpdate(postId:Int,UpdateRequest)
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
        case .searchRecord: return .get
        case .recordIspublic: return .put
        case .recordDelete: return .delete
        case .recordUpdate: return .put
        }
    }
    
    var path: String {
        switch self {
        case .select: return "/select"
        case .category(let cate, _): return "/select/category/\(cate)"
        case .myRecord(let user): return "/\(user)"
        case .save: return "/save"
        case .searchRecord(let id,_): return "/select/\(id)"
        case .recordIspublic(let id): return "/\(id)/ispublic"
        case .recordDelete(let id): return "/delete/\(id)"
        case .recordUpdate(let id,_): return "/update/\(id)"
        }
    }
    
    var parameters: RequestParams? {
        switch self {
        case .select: return nil
        case .category(_,let request): return .query(request)
        case .myRecord: return nil
        case .save(let request): return .body(request)
        case .searchRecord(_,let request): return .query(request)
        case .recordIspublic: return nil
        case .recordDelete: return nil
        case .recordUpdate(_,let request): return .body(request)
        }
    }
    
    
}
