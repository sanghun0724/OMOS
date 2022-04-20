//
//  OneMusicRecord.swift
//  Omos
//
//  Created by sangheon on 2022/03/10.
//

import Foundation

struct OneMusicRecordRespone: Codable {
       let music: Music
       let recordID: Int
       let recordTitle, recordContents, createdDate: String
       let recordImageURL: String?
       let category: String
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

struct OneMusicRecordRequest: Codable {
    let postId: Int?
    let size: Int
    let userId: Int
    let sortType: String
}
