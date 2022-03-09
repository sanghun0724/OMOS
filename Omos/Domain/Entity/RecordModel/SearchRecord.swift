//
//  SearchRecord.swift
//  Omos
//
//  Created by sangheon on 2022/03/09.
//

import Foundation

struct SearchRecordRequest:Codable {
    let postId:Int?
    let size:Int
    let userId:Int
}

struct SearchRecordRespone:Codable {
    
}
