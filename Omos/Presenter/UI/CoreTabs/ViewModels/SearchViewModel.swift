//
//  SearchViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/02/09.
//

import Foundation
import RxSwift

class SearchViewModel :BaseViewModel{
    
    let allLoading = BehaviorSubject<Bool>(value:false)
    let trackLoading = BehaviorSubject<Bool>(value:false)
    let albumLoading = BehaviorSubject<Bool>(value:false)
    let artistLoading = BehaviorSubject<Bool>(value:false)
    let album = PublishSubject<[AlbumRespone]>()
    let artist = PublishSubject<[ArtistRespone]>()
    let track = PublishSubject<[TrackRespone]>()
    var currentAlbum:[AlbumRespone] = []
    var currentArtist:[ArtistRespone] = []
    var currentTrack:[TrackRespone] = []
    var isEmpty = PublishSubject<Bool>()
    let errorMessage = BehaviorSubject<String?>(value: nil)
    let isReload = BehaviorSubject<Bool>(value:false)
    var currentKeyword = ""
    let usecase:SearchUseCase
    
    
    
    
    func searchAllResult(request:musicRequest) {
        allLoading.onNext(true)
        trackLoading.onNext(true)
        albumLoading.onNext(true)
        artistLoading.onNext(true)
        
        Observable.zip(trackLoading, albumLoading, artistLoading)
        { !($0 || $1 || $2) }
       //.throttle(RxTimeInterval.seconds(3), scheduler: MainScheduler.instance)
        .subscribe(onNext:{ [weak self] event in
            if event {
                self?.allLoading.onNext(false)
            }
        }).disposed(by: disposeBag)
        
        albumFetch(request: request)
        trackFetch(request: request)
        artistFetch(request: request)
    }
    
    func albumFetch(request:musicRequest) {
        usecase.albumFetch(request: request)
            .subscribe({ [weak self] event in
                self?.albumLoading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentAlbum += data
                    self?.album.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    func artistFetch(request:musicRequest) {
        usecase.artistFetch(request: request)
            .subscribe({ [weak self] event in
                self?.artistLoading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentArtist += data
                    self?.artist.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    func trackFetch(request:musicRequest) {
        usecase.trackFetch(request: request)
            .subscribe({ [weak self] event in
                self?.trackLoading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentTrack += data
                    self?.track.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    
    init(usecase:SearchUseCase) {
        self.usecase = usecase
        super.init()
        //self.reduce()
    }
    
//    func reduce() {
//        musics
//            .withUnretained(self)
//            .subscribe(onNext: { owner,musics in
//                if musics.isEmpty {
//                    owner.isEmpty.onNext(true)
//                } else {
//                    owner.isEmpty.onNext(false)
//                }
//            }).disposed(by: disposeBag)
//    }
    
}
