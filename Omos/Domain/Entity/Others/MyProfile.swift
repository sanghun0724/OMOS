//
//  MyProfile.swift
//  Omos
//
//  Created by sangheon on 2022/03/20.
//

import Foundation

class PWUpdateRequest:Codable {
    let password:String
    let userId:Int
}

class myProfileResponse:Codable {
   let nickname:String
   let profileUrl: String
   let userId: Int
}

class ProfileUpdateRequest:Codable {
   let nickname:String
   let profileUrl: String
   let userId: Int
}
