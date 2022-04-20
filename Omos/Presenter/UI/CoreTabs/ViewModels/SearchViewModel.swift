//
//  SearchViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/02/09.
//

import Foundation
import RxSwift

class SearchViewModel: BaseViewModel {
    // DATA
    var searchType: SearchType = .main
    let allLoading = BehaviorSubject<Bool>(value: false)
    let trackLoading = BehaviorSubject<Bool>(value: false)
    let albumLoading = BehaviorSubject<Bool>(value: false)
    let artistLoading = BehaviorSubject<Bool>(value: false)
    let album = PublishSubject<[AlbumRespone]>()
    let artist = PublishSubject<[ArtistRespone]>()
    let track = PublishSubject<[TrackRespone]>()
    var currentAlbum: [AlbumRespone] = []
    var currentArtist: [ArtistRespone] = []
    var currentTrack: [TrackRespone] = []
    var currentKeyword = ""
    let searchTrack = PublishSubject<[TrackTitleRespone]>()
    var currentSearchTrack: [TrackTitleRespone] = []

    let errorMessage = BehaviorSubject<String?>(value: nil)
    let isReload = BehaviorSubject<Bool>(value: false)

    // EMPTY
    var isAllEmpty = PublishSubject<Bool>()
    var isTrackEmpty = PublishSubject<Bool>()
    var isAlbumEmpty = PublishSubject<Bool>()
    var isArtistEmpty = PublishSubject<Bool>()

    let usecase: SearchUseCase

    func searchAllResult(keyword: String) {
        allLoading.onNext(true)
        trackLoading.onNext(true)
        albumLoading.onNext(true)
        artistLoading.onNext(true)

        Observable.zip(trackLoading, albumLoading, artistLoading) { !($0 || $1 || $2) }
       // .throttle(RxTimeInterval.seconds(3), scheduler: MainScheduler.instance)
        .subscribe(onNext: { [weak self] event in
            if event {
                self?.allLoading.onNext(false)
            }
        }).disposed(by: disposeBag)

        albumFetch(request: .init(keyword: keyword, limit: 20, offset: 0, type: nil))
        trackFetch(request: .init(keyword: keyword, limit: 20, offset: 0, type: 2))
        artistFetch(request: .init(keyword: keyword, limit: 20, offset: 0, type: nil))
    }

    func albumFetch(request: MusicRequest) {
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

    func artistFetch(request: MusicRequest) {
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

    func trackFetch(request: MusicRequest) {
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

    func trackSearchFetch(request: MusicRequest) {
        usecase.searchTrackFetch(request: request)
            .subscribe({ [weak self] event in
                switch event {
                case .success(let data):
                    self?.currentSearchTrack = data
                    self?.searchTrack.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }

    init(usecase: SearchUseCase) {
        self.usecase = usecase
        super.init()
        self.reduce()
    }

    func reduce() {
        track.withUnretained(self)
            .subscribe(onNext: { owner, _ in
                if owner.currentTrack.isEmpty {
                    owner.isTrackEmpty.onNext(true)
                } else {
                    owner.isTrackEmpty.onNext(false)
                }
            }).disposed(by: disposeBag)

        album.withUnretained(self)
            .subscribe(onNext: { owner, _ in
                if owner.currentTrack.isEmpty {
                    owner.isAlbumEmpty.onNext(true)
                } else {
                    owner.isAlbumEmpty.onNext(false)
                }
            }).disposed(by: disposeBag)

        artist.withUnretained(self)
            .subscribe(onNext: { owner, _ in
                if owner.currentTrack.isEmpty {
                    owner.isArtistEmpty.onNext(true)
                } else {
                    owner.isArtistEmpty.onNext(false)
                }
            }).disposed(by: disposeBag)
    }
}
