//
//  MyProfileTarget.swift
//  Omos
//
//  Created by sangheon on 2022/03/20.
//

import Foundation
import Alamofire

enum MyProfileTarget {
    case myProfile(userId:Int)
    case updatePassword(PWUpdateRequest)
    case updateProfile(ProfileUpdateRequest)
    case userReport(userId:Int)
}

extension MyProfileTarget:TargetType {
    var baseURL: String {
        return "http://ec2-3-37-146-80.ap-northeast-2.compute.amazonaws.com:8080/api/user"
    }
    
    var method: HTTPMethod {
        switch self {
        case .myProfile: return .get
        case .updatePassword: return .put
        case .updateProfile: return .put
        case .userReport: return .put
        }
        
    }
        var path: String {
            switch self {
            case .myProfile(let user): return "/\(user)"
            case .updatePassword: return "/update/password"
            case .updateProfile: return "/update/profile"
            case .userReport(let user): return "/\(user)/report"
            }
        }
        
        var parameters: RequestParams? {
            switch self {
            case .updatePassword(let request): return .body(request)
            case .updateProfile(let request): return .body(request)
            default:
                return nil
            }
        }
    
    }
