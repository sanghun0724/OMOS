//
//  SearchAlbumDetailViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/03/08.
//

import Foundation
import RxSwift

class SearchAlbumDetailViewModel: BaseViewModel {
    let albumDetails = PublishSubject<[AlbumDetailRespone]>()
    var currentAlbumDetails: [AlbumDetailRespone] = []
    let errorMessage = BehaviorSubject<String?>(value: nil)
    let isEmpty = PublishSubject<Bool>()
    let loading = BehaviorSubject<Bool>(value: false)
    let usecase: SearchUseCase

    func albumDetailFetch(albumId: String) {
        loading.onNext(true)
        usecase.albumDetialFetch(albumId: albumId)
            .subscribe({ [weak self] result in
                switch result {
                case .success(let data):
                    self?.loading.onNext(false)
                    self?.currentAlbumDetails = data
                    self?.albumDetails.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }

    init(usecase: SearchUseCase) {
        self.usecase = usecase
        super.init()
        // self.reduce()
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
