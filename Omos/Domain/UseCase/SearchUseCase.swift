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
    
    func albumFetch(request:MusicRequest) -> Single<[AlbumRespone]> {
        return searchRepository.albumFetch(request: request)
    }
    func artistFetch(request:MusicRequest) -> Single<[ArtistRespone]> {
        return searchRepository.artistFetch(request: request)
    }
    
    func albumDetialFetch(albumId:String) -> Single<[AlbumDetailRespone]> {
        return searchRepository.albumDetailFetch(albumId: albumId)
    }
    
    func trackFetch(request:MusicRequest) -> Single<[TrackRespone]> {
        return searchRepository.trackFetch(request: request)
    }
    
    func searchTrackFetch(request:MusicRequest) -> Single<[TrackTitleRespone]> {
        return searchRepository.searchTrackFetch(request: request)
    }
    
    func trackDetailFetch(trackId:String) -> Single<TrackRespone> {
        return searchRepository.trackDetailFetch(trackId: trackId)
    }
    
    func artistDetailTrackFetch(artistId:String) -> Single<[ArtistDetailRespone]> {
        return searchRepository.artistDetailTrackFetch(artistId: artistId)
    }
    
    func artistDetailAlbumFetch(artistId:String,request:ArtistRequest) -> Single<[AlbumRespone]> {
        return searchRepository.artistDetailAlbumFetch(artistId: artistId, request: request)
    }
    
}
