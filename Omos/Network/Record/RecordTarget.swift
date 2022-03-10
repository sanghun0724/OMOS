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
    case recordIspublic(postId:Int)
    case recordDelete(postId:Int)
    case recordUpdate(postId:Int,UpdateRequest)
    case oneMusicRecord(musicId:String,OneMusicRecordRequest)
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
        case .recordIspublic: return .put
        case .recordDelete: return .delete
        case .recordUpdate: return .put
        case .oneMusicRecord: return .get
        }
    }
    
    var path: String {
        switch self {
        case .select: return "/select"
        case .category(let cate, _): return "/select/category/\(cate)"
        case .myRecord(let user): return "/\(user)"
        case .save: return "/save"
        case .recordIspublic(let id): return "/\(id)/ispublic"
        case .recordDelete(let id): return "/delete/\(id)"
        case .recordUpdate(let id,_): return "/update/\(id)"
        case .oneMusicRecord(let id,_): return "/select/music/\(id)"
        }
    }
    
    var parameters: RequestParams? {
        switch self {
        case .select: return nil
        case .category(_,let request): return .query(request)
        case .myRecord: return nil
        case .save(let request): return .body(request)
        case .recordIspublic: return nil
        case .recordDelete: return nil
        case .recordUpdate(_,let request): return .body(request)
        case .oneMusicRecord(_,let request): return .query(request)
        }
    }
    
    
}
