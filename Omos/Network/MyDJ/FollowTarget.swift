//
//  FollowTarget.swift
//  Omos
//
//  Created by sangheon on 2022/03/12.
//

import Alamofire
import Foundation

enum FollowTarget {
    case saveFollow(fromId: Int, toId: Int)
    case deleteFollow(fromId: Int, toId: Int)
    case myDjProfile(fromId: Int, toId: Int)
    case myDjList(userId: Int)
    case followers(userId: Int)
    case followings(userId: Int)
}

extension FollowTarget: TargetType {
    var baseURL: String {
        RestApiUrl.restUrl + "/follow"
    }

    var method: HTTPMethod {
        switch self {
        case .saveFollow: return .post
        case .deleteFollow: return .delete
        case .myDjProfile: return .get
        case .myDjList: return .get
        case .followers: return .get
        case .followings: return .get
        }
    }

    var path: String {
        switch self {
        case let .saveFollow(from, to): return "/save/\(from)/\(to)"
        case let .deleteFollow(from, to): return "/delete/\(from)/\(to)"
        case let .myDjProfile(from, to): return "/select/\(from)/\(to)"
        case .myDjList(let user): return "/select/myDj/\(user)"
        case .followers(let user): return "/select/\(user)/follower"
        case .followings(let user): return "/select/\(user)/following"
        }
    }

    var parameters: RequestParams? {
        switch self {
        default:
            return nil
        }
    }
}
