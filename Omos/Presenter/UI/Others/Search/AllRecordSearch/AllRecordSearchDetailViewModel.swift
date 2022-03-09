//
//  AllRecordSearchDetailViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/03/09.
//

import Foundation
import RxSwift

class AllRecordSearchDetailViewModel:BaseViewModel {


    class AllRecordViewModel:BaseViewModel {
        
        let loading = BehaviorSubject<Bool>(value:false)
        let searchAllRecords = PublishSubject<[SearchRecordRespone]>()
        let currentSearchAllRecords:[SearchRecordRespone] = []
        let errorMessage = BehaviorSubject<String?>(value: nil)
        let usecase:RecordsUseCase
        
        
        func selectRecordsShow() {
            
        }
        
        
        init(usecase:RecordsUseCase) {
            self.usecase = usecase
            super.init()
        }
        
        
    }

}
