//
//  SearchTarget.swift
//  Omos
//
//  Created by sangheon on 2022/03/06.
//

import Foundation
import Alamofire

enum SearchTarget {
    case searchAlbum(musicRequest)
    case searchArtist(musicRequest)
    case searchTrack(musicRequest)
}

extension SearchTarget:TargetType {
    var baseURL: String {
        return "http://ec2-3-37-146-80.ap-northeast-2.compute.amazonaws.com:8080/api/search"
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchAlbum: return .get
        case .searchArtist: return .get
        case .searchTrack: return .get
        }
    }
    
    var path: String {
        switch self {
        case .searchAlbum: return "/album"
        case .searchArtist: return "/artist"
        case .searchTrack: return "/track"
        }
    }
    
    var parameters: RequestParams? {
        switch self {
        case .searchAlbum(let request): return .query(request)
        case .searchArtist(let request): return .query(request)
        case .searchTrack(let request): return .query(request)
        }
    }
    
    
}
