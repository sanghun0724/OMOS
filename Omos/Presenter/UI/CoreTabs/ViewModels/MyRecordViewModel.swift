//
//  MyRecordViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/02/20.
//

import Foundation
import RxSwift

class MyRecordViewModel: BaseViewModel {
    let loading = BehaviorSubject<Bool>(value: false)
    let myRecords = BehaviorSubject<[MyRecordRespone]>(value: [])
    let isEmpty = PublishSubject<Bool>()
    var currentMyRecords: [MyRecordRespone] = []
    let errorMessage = BehaviorSubject<String?>(value: nil)
    let usecase: RecordsUseCase

    init(usecase: RecordsUseCase) {
        self.usecase = usecase
        super.init()
        self.reduce()
    }

    func myRecordFetch(userid: Int) {
        loading.onNext(true)
        usecase.myRecordFetch(userid: userid)
            .subscribe({ [weak self] event in
                self?.loading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentMyRecords = data
                    self?.myRecords.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }

    func reduce() {
        myRecords
            .withUnretained(self)
            .subscribe(onNext: { owner, record in
                if record.isEmpty {
                    owner.isEmpty.onNext(true)
                } else {
                    owner.isEmpty.onNext(false)
                }
            }).disposed(by: disposeBag)
    }
}
