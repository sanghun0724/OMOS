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
                    self?.currentPopuralRecord = data
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
