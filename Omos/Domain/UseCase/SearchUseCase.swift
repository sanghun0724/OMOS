//
//  SearchUseCase.swift
//  Omos
//
//  Created by sangheon on 2022/03/06.
//

import Foundation
import RxSwift


class SearchUseCase {
    private let searchRepository:SearchRepository
    
    init(searchRepository:SearchRepository) {
        self.searchRepository = searchRepository
    }
    
    func albumFetch(request:musicRequest) -> Single<[AlbumRespone]> {
        return searchRepository.albumFetch(request: request)
    }
    func artistFetch(request:musicRequest) -> Single<[ArtistRespone]> {
        return searchRepository.artistFetch(request: request)
    }
    func trackFetch(request:musicRequest) -> Single<[TrackRespone]> {
        return searchRepository.trackFetch(request: request)
    }
}
