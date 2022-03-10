//
//  MyRecord.swift
//  Omos
//
//  Created by sangheon on 2022/03/04.
//

import Foundation

// MARK: - MyRecordElement
struct MyRecordRespone: Codable {
       let music: Music
       let recordID: Int
       let recordTitle, recordContents: String
       let recordImageURL: String?
       let createdDate: String
       let category: String
       let viewsCnt, userID: Int
       let nickname: String
       let likeCnt, scrapCnt: Int
       let isLiked, isScraped, isPublic: Bool

       enum CodingKeys: String, CodingKey {
           case music
           case recordID = "recordId"
           case recordTitle, recordContents
           case recordImageURL = "recordImageUrl"
           case createdDate, category, viewsCnt
           case userID = "userId"
           case nickname, likeCnt, scrapCnt, isLiked, isScraped, isPublic
       }
}



// MARK: - MyRecord
struct SaveRequest: Codable { // add imageURL or image data using form - data
        let category: String
        let isPublic: Bool
        let musicID, recordContents, recordImageURL, recordTitle: String
        let userID: Int

        enum CodingKeys: String, CodingKey {
            case category, isPublic
            case musicID = "musicId"
            case recordContents
            case recordImageURL = "recordImageUrl"
            case recordTitle
            case userID = "userId"
        }
}

struct SaveRespone:Codable {
    let state:Bool
}


struct UpdateRequest:Codable {
    let contents:String
    let title:String
}

struct PostRespone:Codable {
    let postId:Int
}

struct StateRespone:Codable {
    let state:Bool
}
