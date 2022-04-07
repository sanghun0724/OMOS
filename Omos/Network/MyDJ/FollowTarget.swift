//
//  FollowTarget.swift
//  Omos
//
//  Created by sangheon on 2022/03/12.
//

import Foundation
import Alamofire

enum FollowTarget {
    case saveFollow(fromId:Int,toId:Int)
    case deleteFollow(fromId:Int,toId:Int)
    case myDjProfile(fromId:Int,toId:Int)
    case myDjList(userId:Int)
}

extension FollowTarget:TargetType {
    var baseURL: String {
        return RestApiUrl.restUrl + "/follow"
    }
    
    var method: HTTPMethod {
        switch self {
        case .saveFollow: return .post
        case .deleteFollow: return .delete
        case .myDjProfile: return .get
        case .myDjList: return .get
        }
    }
    
    var path: String {
        switch self {
        case .saveFollow(let from,let to): return "/save/\(from)/\(to)"
        case .deleteFollow(let from,let to): return "/delete/\(from)/\(to)"
        case .myDjProfile(let from,let to): return "/select/\(from)/\(to)"
        case .myDjList(let user): return "/select/myDj/\(user)"
        }
    }
    
    var parameters: RequestParams? {
        switch self {
        default:
            return nil
        }
    }
    
    
}
