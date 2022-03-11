//
//  InteractionTarget.swift
//  Omos
//
//  Created by sangheon on 2022/03/11.
//

import Foundation
import Alamofire

enum InteractionTarget {
    case saveScrap(postId:Int,userId:Int)
    case deleteScrap(postId:Int,userId:Int)
    case saveLike(postId:Int,userId:Int)
    case deleteLike(postId:Int,userId:Int)
}

extension InteractionTarget:TargetType {
    var baseURL: String {
        return "http://ec2-3-37-146-80.ap-northeast-2.compute.amazonaws.com:8080/api/"
    }
    
    var method: HTTPMethod {
        switch self {
        case .saveScrap: return .post
        case .deleteScrap: return .delete
        case .saveLike: return .post
        case .deleteLike: return .delete
        }
    }
    
    var path: String {
        switch self {
        case .saveScrap(let post,let user): return "\(post)/\(user)"
        case .deleteScrap(let post,let user): return "\(post)/\(user)"
        case .saveLike(let post,let user): return "\(post)/\(user)"
        case .deleteLike(let post,let user): return "\(post)/\(user)"
        }
    }
    
    var parameters: RequestParams? {
        switch self {
        default:
            return nil
        }
    }
    
    
}
