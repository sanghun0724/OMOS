//
//  SearchRepositoryImpl.swift
//  Omos
//
//  Created by sangheon on 2022/03/06.
//

import Foundation
import RxSwift
import Alamofire

class SearchRepositoryImpl:SearchRepository {
    
    var searchAPI:SearchAPI
    
    required init(searchAPI: SearchAPI) {
        self.searchAPI = searchAPI
    }
    
    func albumFetch(request: musicRequest) -> Single<[AlbumRespone]> {
        return Single<[AlbumRespone]>.create { [weak self] single in
            self?.searchAPI.albumFetch(request: request, completion: { result in
                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            })
            
            return Disposables.create()
        }
    }
    
    func artistFetch(request: musicRequest) -> Single<[ArtistRespone]> {
        return Single<[ArtistRespone]>.create { [weak self] single in
            self?.searchAPI.artistFetch(request: request, completion: { result in
                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            })
            
            return Disposables.create()
        }
    }
    
    func trackFetch(request: musicRequest) -> Single<[TrackRespone]> {
        return Single<[TrackRespone]>.create { [weak self] single in
            self?.searchAPI.trackFetch(request: request, completion: { result in
                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            })
            
            return Disposables.create()
        }
    }
    
    func albumDetailFetch(albumId:String) -> Single<[AlbumDetailRespone]> {
        return Single<[AlbumDetailRespone]>.create { [weak self] single in
            self?.searchAPI.albumDetailFetch(albumId:albumId , completion: { result in
                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            })
            
            return Disposables.create()
        }
    }
    
    func trackDetailFetch(trackId:String) -> Single<TrackRespone> {
        return Single<TrackRespone>.create { [weak self] single in
            self?.searchAPI.trackDetailFetch(trackId:trackId , completion: { result in
                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            })
            
            return Disposables.create()
        }
    }
    
    func artistDetailTrackFetch(artistId:String) -> Single<[ArtistDetailRespone]> {
        return Single<[ArtistDetailRespone]>.create { [weak self] single in
            self?.searchAPI.ArtistDetailTrackFetch(artistId:artistId , completion: { result in
                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            })
            
            return Disposables.create()
        }
    }
    
    
    
    func artistDetailAlbumFetch(artistId:String,request:musicRequest) -> Single<[AlbumRespone]> {
        return Single<[AlbumRespone]>.create { [weak self] single in
            self?.searchAPI.ArtistDetailAlbumFetch(artistId: artistId, request: request, completion: { result in
                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            })
            
            return Disposables.create()
        }
    }
    
}
