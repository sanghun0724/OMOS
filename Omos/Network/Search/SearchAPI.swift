//
//  SearchAPI.swift
//  Omos
//
//  Created by sangheon on 2022/03/06.
//

import Foundation
import RxSwift
import Alamofire

class SearchAPI {
    
    func albumFetch(request:musicRequest,completion:@escaping(Result<[AlbumRespone],Error>) -> Void) {
        AF.request(SearchTarget.searchAlbum(request),interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<[AlbumRespone]>) in
            switch response.result {
            case .success(let data):
                print(data)
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func artistFetch(request:musicRequest,completion:@escaping(Result<[ArtistRespone],Error>) -> Void) {
        AF.request(SearchTarget.searchArtist(request),interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<[ArtistRespone]>) in
            switch response.result {
            case .success(let data):
                print(data)
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func trackFetch(request:musicRequest,completion:@escaping(Result<[TrackRespone],Error>) -> Void) {
        AF.request(SearchTarget.searchTrack(request),interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<[TrackRespone]>) in
            switch response.result {
            case .success(let data):
                print(data)
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    
}
