//
//  HomeViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/03/15.
//

import Foundation
import RxRelay
import RxSwift

class HomeViewModel: BaseViewModel {
    let popuralRecord = PublishSubject<[PopuralResponse]>()
    var currentPopuralRecord: [PopuralResponse] = []
    let lovedRecord = PublishSubject<LovedResponse>()
    var currentLovedRecord: LovedResponse?
    let recommendRecord = PublishSubject<[RecommendDjResponse]>()
    var currentRecommentRecord: [RecommendDjResponse] = []
    let todayRecord = PublishSubject<TodayTrackResponse>()
    var currentTodayRecord: TodayTrackResponse?

    let allLoading = PublishSubject<Bool>()
    let popuralLoading = PublishSubject<Bool>()
    let lovedLoading = PublishSubject<Bool>()
    let recommendLoading = PublishSubject<Bool>()
    let todayLoading = PublishSubject<Bool>()

    let lovedIsEmpty = BehaviorSubject<Bool>(value: false)
    let errorMessage = BehaviorSubject<String?>(value: nil)
    let usecase: TodayUseCase

    func allHomeDataFetch(userId: Int) {
        allLoading.onNext(true)
        Observable.combineLatest(popuralLoading, lovedLoading, recommendLoading, todayLoading) { !($0 && $1 && $2 && $3) }
        .filter { $0 }
        .subscribe(onNext: { [weak self] _ in
                self?.allLoading.onNext(false)
        }).disposed(by: disposeBag)

        self.fetchLovedRecord(userId: userId)
        self.fetchPopuralRecord()
        self.fetchRecommendDj()
        self.fetchTodayRecord()
    }

    func fetchPopuralRecord() {
        popuralLoading.onNext(true)
        usecase.popuralRecord()
            .subscribe({ [weak self] event in
                self?.popuralLoading.onNext(false)
                switch event {
                case .success(let data):
                let test = [ PopuralResponse(music: Music(albumImageURL: "https://i.scdn.co/image/ab67616d00001e020774e9bcd9d27d9cc64712ce", albumTitle: "Goodbye, grief.", artists: [Omos.Artist(artistID: "6evmYxFbDSIHilUaYC9MhL", artistName: "자우림")], musicID: "4gLkg28D1HCQkQemOceg4x", musicTitle: "이카루스"), nickname: "Ilish", recordID: 322, recordImageURL: "https://omos-image.s3.ap-northeast-2.amazonaws.com/record/1031649638831440.png", recordTitle: "자, 힘차게 날개를 펴고 날아보자", userID: 103), PopuralResponse(music: Music(albumImageURL: "https://i.scdn.co/image/ab67616d00001e02bf55580ea719aa52c2bbece7", albumTitle: "PROTOTYPE RESEARCH #0063", artists: [Artist(artistID: "31VffPWiL2AAwNIMODB9qZ", artistName: "김승민"), Artist(artistID: "2FgZrgTMX6Sk0VNcOsEPmm", artistName: "펀치")], musicID: "6eyVKpe2LGukVfC8wpd3D2", musicTitle: "One, Two (Feat. Punch)"), nickname: "재르민", recordID: 313, recordImageURL: "https://omos-image.s3.ap-northeast-2.amazonaws.com/record/1081649591110551.png", recordTitle: "내려가는 길", userID: 108), PopuralResponse(music: Music(albumImageURL: "https://i.scdn.co/image/ab67616d00001e02344da4e90fc0daf77f1b8d2b", albumTitle: "Great Wave", artists: [Artist(artistID: "4xgRWQOK2y3pGRFtmWNjyw", artistName: "신승훈")], musicID: "4L0l5DqXYIHoUdb7HvauOH", musicTitle: "Sorry"), nickname: "루시", recordID: 358, recordImageURL: "https://omos-image.s3.ap-northeast-2.amazonaws.com/record/301650987206168.png", recordTitle: "아직도 내 기억들이 따끔거리길", userID: 30) ]
                    self?.currentPopuralRecord = test
                    self?.popuralRecord.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }

    func fetchLovedRecord(userId: Int) {
        lovedLoading.onNext(true)
        usecase.lovedRecord(userId: userId)
            .subscribe({ [weak self] event in
                self?.lovedLoading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentLovedRecord = data
                    self?.lovedRecord.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }

    func fetchRecommendDj() {
        recommendLoading.onNext(true)
        usecase.recommendDJRecord()
            .subscribe({ [weak self] result in
                self?.recommendLoading.onNext(false)
                switch result {
                case .success(let data):
                    self?.currentRecommentRecord = data
                    self?.currentRecommentRecord = [RecommendDjResponse(nickname: "Ilish", profileURL: Optional("https://omos-image.s3.ap-northeast-2.amazonaws.com/profile/103.png"), userID: 103), RecommendDjResponse(nickname: "맹고", profileURL: Optional("https://omos-image.s3.ap-northeast-2.amazonaws.com/profile/120.png"), userID: 120), RecommendDjResponse(nickname: "지지니", profileURL: nil, userID: 123)]
                    self?.recommendRecord.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }

    func fetchTodayRecord() {
        todayLoading.onNext(true)
        usecase.todayRecord()
            .subscribe({ [weak self] event in
                self?.todayLoading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentTodayRecord = data
                    self?.todayRecord.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }

    init(usecase: TodayUseCase) {
        self.usecase = usecase
        super.init()
    }

//    func reduce() {
//        myRecords
//            .withUnretained(self)
//            .subscribe(onNext: { owner,record in
//                if record.isEmpty {
//                    owner.isEmpty.onNext(true)
//                } else {
//                    owner.isEmpty.onNext(false)
//                }
//            }).disposed(by: disposeBag)
//    }

}
