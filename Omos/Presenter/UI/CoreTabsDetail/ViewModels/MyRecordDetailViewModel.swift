//
//  MyRecordDetailViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/03/10.
//

import Foundation
import RxSwift

class MyRecordDetailViewModel:BaseViewModel {
    
    let delete = PublishSubject<Bool>()
    let modify = PublishSubject<Bool>()
    let done = PublishSubject<Bool>()
    var recordData:MyRecordRespone? = nil
    let usecase:RecordsUseCase
    
    func deleteRecord(postId:Int) {
        usecase.recordDelete(postId: postId)
            .subscribe({ [weak self] _ in
                self?.done.onNext(true)
            }).disposed(by: disposeBag)
    }
    
    init(usecase:RecordsUseCase) {
        self.usecase = usecase
        super.init()
    }
    
}
