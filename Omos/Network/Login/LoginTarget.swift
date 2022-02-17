//
//  LoginTarget.swift
//  Omos
//
//  Created by sangheon on 2022/02/17.
//

import Alamofire

enum LoginTarget {
    case login(LoginRequest)
    case getUserDetails(UserDetailRequest)
}

extension LoginTarget:TargetType {
    var baseURL: String {
        return ""
    }
    
    var method: HTTPMethod {
        switch self {
        case .login: return .post
        case .getUserDetails: return .get
        }
    }
    
    var path: String {
        switch self {
        case .login: return "/login"
        case .getUserDetails: return "/details" //it could be changed
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .login(let request): return .body(request)
        case .getUserDetails(let request): return .body(request)
        }
    }
    
    
}
