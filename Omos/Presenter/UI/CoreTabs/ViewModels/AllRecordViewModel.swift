//
//  AllRecordViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import Foundation
import RxSwift


class AllRecordViewModel:BaseViewModel {
    
    let loading = BehaviorSubject<Bool>(value:false)
    let selectRecords = BehaviorSubject<SelectResponse>(value:.init(aLine: [], ost: [], free: []))
    var currentSelectRecords:SelectResponse = .init(aLine: [], ost: [], free: [])
    let errorMessage = BehaviorSubject<String?>(value: nil)
    let usecase:RecordsUseCase
    
    
    func selectRecordsShow() {
        usecase.selectRecord()
            .subscribe({ [weak self] event in
                switch event {
                case .success(let data):
                    print("success")
                    self?.currentSelectRecords = data
                    self?.selectRecords.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    func numberofRows() -> Int {
        return 5
    }
    
    
    init(usecase:RecordsUseCase) {
        self.usecase = usecase
        super.init()
    }
    
    
}
