//
//  SearchArtistDetailViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/03/08.
//

import Foundation
import RxSwift

class SearchArtistDetailViewModel:BaseViewModel {
    
    let artistTrack = PublishSubject<[ArtistDetailRespone]>()
    var currentArtistTrack:[ArtistDetailRespone] = []
    let artistAlbum = PublishSubject<[AlbumRespone]>()
    var currentArtistAlbum:[AlbumRespone] = []
    let errorMessage = BehaviorSubject<String?>(value: nil)
    let isEmpty = PublishSubject<Bool>()
    let loading = BehaviorSubject<Bool>(value:false)
    let usecase:SearchUseCase
    
    
    func artistDetailTrackFetch(artistId:String) {
        usecase.artistDetailTrackFetch(artistId: artistId)
            .subscribe({ [weak self] event in
                switch event {
                case .success(let data):
                    self?.currentArtistTrack = data
                    self?.artistTrack.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    func artistDetailAlbumFetch(artistId:String,request:musicRequest) {
        usecase.artistDetailAlbumFetch(artistId: artistId, request: request)
            .subscribe({ [weak self] event in
                switch event {
                case .success(let data):
                    self?.currentArtistAlbum = data
                    self?.artistAlbum.onNext(data)
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
