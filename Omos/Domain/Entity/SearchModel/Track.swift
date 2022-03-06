//
//  Track.swift
//  Omos
//
//  Created by sangheon on 2022/03/06.
//

import Foundation

struct TrackRespone:Codable {
    let musicID, musicTitle: String
    let artists: [Artist]
    let albumImageURL: String
    let releaseDate, albumTitle, albumID: String
    
    enum CodingKeys: String, CodingKey {
        case musicID = "musicId"
        case musicTitle, artists
        case albumImageURL = "albumImageUrl"
        case releaseDate, albumTitle
        case albumID = "albumId"
    }
}

