//
//  SearchUseCase.swift
//  Omos
//
//  Created by sangheon on 2022/03/06.
//

import Foundation
import RxSwift

class SearchUseCase {
    private let searchRepository: SearchRepository

    init(searchRepository: SearchRepository) {
        self.searchRepository = searchRepository
    }

    func albumFetch(request: MusicRequest) -> Single<[AlbumRespone]> {
        searchRepository.albumFetch(request: request)
    }
    func artistFetch(request: MusicRequest) -> Single<[ArtistRespone]> {
        searchRepository.artistFetch(request: request)
    }

    func albumDetialFetch(albumId: String) -> Single<[AlbumDetailRespone]> {
        searchRepository.albumDetailFetch(albumId: albumId)
    }

    func trackFetch(request: MusicRequest) -> Single<[TrackRespone]> {
        searchRepository.trackFetch(request: request)
    }

    func searchTrackFetch(request: MusicRequest) -> Single<[TrackTitleRespone]> {
        searchRepository.searchTrackFetch(request: request)
    }

    func trackDetailFetch(trackId: String) -> Single<TrackRespone> {
        searchRepository.trackDetailFetch(trackId: trackId)
    }

    func artistDetailTrackFetch(artistId: String) -> Single<[ArtistDetailRespone]> {
        searchRepository.artistDetailTrackFetch(artistId: artistId)
    }

    func artistDetailAlbumFetch(artistId: String, request: ArtistRequest) -> Single<[AlbumRespone]> {
        searchRepository.artistDetailAlbumFetch(artistId: artistId, request: request)
    }
}
