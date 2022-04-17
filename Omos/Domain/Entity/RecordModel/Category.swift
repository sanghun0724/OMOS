//
//  Category.swift
//  Omos
//
//  Created by sangheon on 2022/03/03.
//

import Foundation

// MARK: CategoryRespone

struct CategoryRespone: Codable {
    let music: Music
    let recordID: Int
    let recordTitle, recordContents: String
    let recordImageURL: String?
    let createdDate, category: String
    let viewsCnt, userID: Int
    let nickname: String
    let likeCnt, scrapCnt: Int
    let isLiked, isScraped: Bool

    enum CodingKeys: String, CodingKey {
        case music
        case recordID = "recordId"
        case recordTitle, recordContents
        case recordImageURL = "recordImageUrl"
        case createdDate, category, viewsCnt
        case userID = "userId"
        case nickname, likeCnt, scrapCnt, isLiked, isScraped
    }
}

enum cateType: String, Codable {
    case A_LINE
    case OST
    case STORY
    case LYRICS
    case FREE
    // 정렬
    case ASC = "ASC"
    case DESC = "DESC"
}

struct CateRequest: Codable {
    let postId: Int?
    let size: Int
    let sortType: String
    let userid: Int
}
