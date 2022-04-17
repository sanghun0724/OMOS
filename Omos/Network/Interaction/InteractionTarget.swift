//
//  InteractionTarget.swift
//  Omos
//
//  Created by sangheon on 2022/03/11.
//

import Alamofire
import Foundation

enum InteractionTarget {
    case saveScrap(postId: Int, userId: Int)
    case deleteScrap(postId: Int, userId: Int)
    case saveLike(postId: Int, userId: Int)
    case deleteLike(postId: Int, userId: Int)
    case block(type: String, BlockRequest)
}

extension InteractionTarget: TargetType {
    var baseURL: String {
        RestApiUrl.restUrl   }

    var method: HTTPMethod {
        switch self {
        case .saveScrap: return .post
        case .deleteScrap: return .delete
        case .saveLike: return .post
        case .deleteLike: return .delete
        case .block: return .post
        }
    }

    var path: String {
        switch self {
        case .saveScrap(let post, let user): return "scrap/save/\(post)/\(user)"
        case .deleteScrap(let post, let user): return "scrap/delete/\(post)/\(user)"
        case .saveLike(let post, let user): return "like/save/\(post)/\(user)"
        case .deleteLike(let post, let user): return "like/delete/\(post)/\(user)"
        case .block(let type, _): return "/block/save/\(type)"
        }
    }

    var parameters: RequestParams? {
        switch self {
        case .block( _, let request): return .body(request)
        default:
            return nil
        }
    }
}
