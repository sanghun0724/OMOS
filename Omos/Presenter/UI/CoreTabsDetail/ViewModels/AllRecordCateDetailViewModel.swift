//
//  AllRecordDetailViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/03/03.
//

import Foundation
import RxSwift


class AllRecordCateDetailViewModel:BaseViewModel {
    
    let loading = BehaviorSubject<Bool>(value:false)
    let cateRecords = BehaviorSubject<[CategoryRespone]>(value: [])
    var currentCateRecords:[CategoryRespone] = []
    let errorMessage = BehaviorSubject<String?>(value: nil)
    let usecase:RecordsUseCase
    
    
    func selectRecordsShow(type: cateType, postId: Int?, size: Int, sort: String, userid: Int) {
        loading.onNext(true)
        usecase.cateFetch(type: type, postId: postId, size: size, sort: sort, userid: userid)
            .subscribe({ [weak self] event in
                self?.loading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentCateRecords = data
                    self?.cateRecords.onNext(data)
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    func numberofRows() -> Int {
        return currentCateRecords.count
    }
    
    
    init(usecase:RecordsUseCase) {
        self.usecase = usecase
        super.init()
    }
    
    
}
