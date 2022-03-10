//
//  AllRecordSearchDetailViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/03/09.
//

import Foundation
import RxSwift

class AllRecordSearchDetailViewModel:BaseViewModel {
    
    
    
    let loading = BehaviorSubject<Bool>(value:false)
    let oneMusicRecords = PublishSubject<[OneMusicRecordRespone]>()
    var currentOneMusicRecords:[OneMusicRecordRespone] = []
    let errorMessage = BehaviorSubject<String?>(value: nil)
    let isEmpty = BehaviorSubject<Bool>(value:false)
    let usecase:RecordsUseCase
    
    
    func oneMusicRecordsFetch(musicId:String,request:OneMusicRecordRequest) {
        loading.onNext(true)
        usecase.oneMusicRecordFetch(musicId: musicId, request: request)
            .subscribe({ [weak self] event in
                self?.loading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentOneMusicRecords += data
                    self?.oneMusicRecords.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                    self?.oneMusicRecords.onNext([])
                }
            }).disposed(by: disposeBag)
        
    }
    
    
    init(usecase:RecordsUseCase) {
        self.usecase = usecase
        super.init()
        self.reduce()
    }
    
    func reduce() {
        oneMusicRecords
            .withUnretained(self)
            .subscribe(onNext: { owner,record in
                if owner.currentOneMusicRecords.isEmpty {
                    owner.isEmpty.onNext(true)
                } else {
                    owner.isEmpty.onNext(false)
                }
            }).disposed(by: disposeBag)
        
    }
    
    
    
    
}
