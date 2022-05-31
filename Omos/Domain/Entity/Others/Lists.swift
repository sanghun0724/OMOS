//
//  Lists.swift
//  Omos
//
//  Created by sangheon on 2022/05/31.
//

import Foundation


struct ListResponse:Codable {
    let nickname: String
    let profileURL: String
    let userID:String
    
    enum CodingKeys:String,CodingKey {
        case nickname
        case profileURL = "profileUrl"
        case userID = "userId"
    }
}
