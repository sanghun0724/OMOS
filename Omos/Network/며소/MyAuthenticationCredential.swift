//
//  MyAuthenticationCredential.swift
//  Omos
//
//  Created by sangheon on 2022/02/17.
//

import Foundation
import Alamofire

struct MyAuthenticationCredential: AuthenticationCredential {
    let accessToken:String
    let refreshToken:String
    let expiredAt:Date
    
    //유효시간 앞으로 5분이하 남았다고 하면 refresh가 필요하다고 true를 리턴
    var requiresRefresh: Bool { Date(timeIntervalSinceNow: 60 * 5) > expiredAt }
    //자동으로 해주는듯?
}


