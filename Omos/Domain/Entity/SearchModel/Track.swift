//
//  Track.swift
//  Omos
//
//  Created by sangheon on 2022/03/06.
//

import Foundation

struct TrackRespone:Codable {
    let albumID, albumImageURL, albumTitle: String
    let artists: [Artist]
    let musicID, musicTitle, releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case albumImageURL = "albumImageUrl"
        case albumTitle, artists
        case musicID = "musicId"
        case musicTitle, releaseDate
    }
}
