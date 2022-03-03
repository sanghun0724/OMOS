//
//  Category.swift
//  Omos
//
//  Created by sangheon on 2022/03/03.
//

import Foundation

// MARK: - CategoryElement
struct CategoryRespone: Codable {
    let category, createdDate: String
    let isLiked, isPublic, isScraped: Bool
    let likeCnt: Int
    let music: Music
    let nickname, recordContents: String
    let recordID: Int
    let recordTitle: String
    let scrapCnt, userID, viewsCnt: Int

    enum CodingKeys: String, CodingKey {
        case category, createdDate, isLiked, isPublic, isScraped, likeCnt, music, nickname, recordContents
        case recordID = "recordId"
        case recordTitle, scrapCnt
        case userID = "userId"
        case viewsCnt
    }
}


//typealias Category = [CategoryRespone]

enum cateType:String,Codable {
    case A_LINE
    case OST
    case STORY
    case LYRICS
    case FREE
    
    enum sortType:String,Codable {
        case ASC
        case DESC
    }
}


struct CateRequest: Codable {
    let page:Int
    let size:Int
    let sort:[cateType]
    let userid:Int
}


