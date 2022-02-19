//
//  LoginRequest.swift
//  Omos
//
//  Created by sangheon on 2022/02/17.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
}


struct Login:Codable {
}

struct LoginResponse:Codable {
    let userId:Int
    let accessToken:String
    let refreshToken:String
}


