//
//  LoginRequest.swift
//  Omos
//
//  Created by sangheon on 2022/02/17.
//

import Foundation

struct LoginRequest: Encodable {
    let userName: String
    let password: String
}


struct Login:Codable {
}

struct LoginResponse:Codable {
    let name:String
    let accessToken:String
    let refreshToken:String
}
