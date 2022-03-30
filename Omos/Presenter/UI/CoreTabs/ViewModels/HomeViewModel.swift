//
//  HomeViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/03/15.
//

import Foundation
import RxSwift
import RxRelay

class HomeViewModel:BaseViewModel {
    
    let popuralRecord = PublishSubject<[PopuralResponse]>()
    var currentPopuralRecord:[PopuralResponse] = []
    let lovedRecord = PublishSubject<LovedResponse>()
    var currentLovedRecord:LovedResponse? = nil
    let recommendRecord = PublishSubject<[recommendDjResponse]>()
    var currentRecommentRecord:[recommendDjResponse] = []
    let todayRecord = PublishSubject<TodayTrackResponse>()
    var currentTodayRecord:TodayTrackResponse? = nil
    
    let allLoading = PublishRelay<Bool>()
    let popuralLoading = PublishSubject<Bool>()
    let lovedLoading = PublishSubject<Bool>()
    let recommendLoading = PublishSubject<Bool>()
    let todayLoading = PublishSubject<Bool>()
    
    let lovedIsEmpty = BehaviorSubject<Bool>(value:false)
    let errorMessage = BehaviorSubject<String?>(value: nil)
    let usecase:TodayUseCase
    
    
    func allHomeDataFetch(userId:Int) {
        allLoading.accept(true)
        Observable.zip(popuralLoading,lovedLoading,recommendLoading,todayLoading)
        { !($0 && $1 && $2 && $3) }
        .subscribe(onNext: { [weak self] loading in
            if loading {
                self?.allLoading.accept(false)
            }
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
    
    func fetchLovedRecord(userId:Int) {
        lovedLoading.onNext(true)
        usecase.lovedRecord(userId:userId)
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
            .subscribe({ [weak self] event in
                self?.recommendLoading.onNext(false)
                switch event {
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
    
    
    
    
    
    
    
    
    
    init(usecase:TodayUseCase) {
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

