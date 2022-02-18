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
    //case kakaoLogin()
    case signUp(SignUpRequest)
    case doRefresh(RefreshRequest)
}

extension LoginTarget:TargetType {
    var baseURL: String {
        return "http://ec2-3-37-146-80.ap-northeast-2.compute.amazonaws.com:8080/api/auth"
    }
    
    var method: HTTPMethod {
        switch self {
        case .login: return .post
        case .getUserDetails: return .get
        case .signUp: return .post
        case .doRefresh: return .post
        }
    }
    
    var path: String {
        switch self {
        case .login: return "/login"
        case .getUserDetails: return "/details" //it could be changed
        case .signUp: return "/signup"
        case .doRefresh: return "/post"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .login(let request): return .body(request)
        case .getUserDetails(let request): return .body(request)
        case .signUp(let request): return .body(request)
        case .doRefresh(let request): return .body(request)
        }
    }
    
    
}
