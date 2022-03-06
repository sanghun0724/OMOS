//
//  SearchRepository.swift
//  Omos
//
//  Created by sangheon on 2022/03/06.
//

import Foundation
import RxSwift

protocol SearchRepository {
    var searchAPI:SearchAPI { get }
    init(searchAPI:SearchAPI)
    func albumFetch(request:musicRequest) -> Single<[AlbumRespone]>
    func artistFetch(request:musicRequest) -> Single<[ArtistRespone]>
    func trackFetch(request:musicRequest) -> Single<[TrackRespone]>
}
