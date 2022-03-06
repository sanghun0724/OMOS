//
//  Artist.swift
//  Omos
//
//  Created by sangheon on 2022/03/06.
//

import Foundation

struct ArtistRespone:Codable {
    let artistID, artistImageURL, artistName: String
    let genres: [String]
    
    enum CodingKeys: String, CodingKey {
        case artistID = "artistId"
        case artistImageURL = "artistImageUrl"
        case artistName, genres
    }
}
