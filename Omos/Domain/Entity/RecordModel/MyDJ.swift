//
//  MyDJ.swift
//  Omos
//
//  Created by sangheon on 2022/03/13.
//

import Foundation


struct MyDjRequest:Codable {
    let postId:Int?
    let size:Int
}

struct MyDjResponse:Codable {
        let category, createdDate: String
        let isLiked, isPublic, isScraped: Bool
        let likeCnt: Int
        let music: Music
        let nickname, recordContents: String
        let recordID: Int
        let recordImageURL, recordTitle: String
        let scrapCnt, userID, viewsCnt: Int

        enum CodingKeys: String, CodingKey {
            case category, createdDate, isLiked, isPublic, isScraped, likeCnt, music, nickname, recordContents
            case recordID = "recordId"
            case recordImageURL = "recordImageUrl"
            case recordTitle, scrapCnt
            case userID = "userId"
            case viewsCnt
        }
}



struct MyDjProfileResponse:Codable {
    let count: Count
    let isFollowed: Bool
    let profile: MyDjListResponse
}

// MARK: - Count
struct Count: Codable {
    let followerCount, followingCount, recordsCount: String
}

// MARK: - Profile
struct MyDjListResponse: Codable {
    let nickName, profileURL: String
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case nickName
        case profileURL = "profileUrl"
        case userID = "userId"
    }
}

