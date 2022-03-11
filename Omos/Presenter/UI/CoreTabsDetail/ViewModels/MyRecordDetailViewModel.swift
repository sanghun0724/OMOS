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
    let errorMessage = BehaviorSubject<String?>(value: nil)
    
    func deleteRecord(postId:Int) {
        usecase.recordDelete(postId: postId)
            .subscribe({ [weak self] _ in
                self?.done.onNext(true)
            }).disposed(by: disposeBag)
    }
    
    //Interation
    func saveScrap(postId:Int,userId:Int) {
        usecase.saveScrap(postId: postId, userId: userId)
            .subscribe({ event in
                print(event)
            }).disposed(by: disposeBag)
    }
    
    func deleteScrap(postId:Int,userId:Int) {
        usecase.deleteScrap(postId: postId, userId: userId)
            .subscribe({ event in
                print(event)
            }).disposed(by: disposeBag)
    }
    
    func saveLike(postId:Int,userId:Int) {
        usecase.saveLike(postId: postId, userId: userId)
            .subscribe({ event in
                print(event)
            }).disposed(by: disposeBag)
    }
    
    func deleteLike(postId:Int,userId:Int) {
        usecase.deleteLike(postId: postId, userId: userId)
            .subscribe({ event in
                print(event)
            }).disposed(by: disposeBag)
    }
    
    
    init(usecase:RecordsUseCase) {
        self.usecase = usecase
        super.init()
    }
    
}
