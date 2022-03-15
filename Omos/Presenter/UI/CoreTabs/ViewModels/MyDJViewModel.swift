//
//  MyDJViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/03/13.
//

import Foundation
import RxSwift

class MyDjViewModel:BaseViewModel {
    
    let myDjRecord = PublishSubject<[MyDjResponse]>()
    var currentMyDjRecord:[MyDjResponse] = []
    let myDjList = PublishSubject<[MyDjListResponse]>()
    var currentMyDjList:[MyDjListResponse] = []
    let loading = BehaviorSubject<Bool>(value:false)
    let isEmpty = BehaviorSubject<Bool>(value:false)
    let errorMessage = BehaviorSubject<String?>(value: nil)
    
    let usecase:RecordsUseCase
    
    func fetchMyDjRecord(userId:Int,request:MyDjRequest) {
        loading.onNext(true)
        usecase.MyDjAllRecord(userId:userId, MyDjRequest: request)
            .subscribe({ [weak self] event in
                self?.loading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentMyDjRecord += data
                    self?.myDjRecord.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    func fetchMyDjList(userId:Int) {
        usecase.myDjList(userId: userId)
            .subscribe({ [weak self] event in
                self?.loading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentMyDjList += data
                    self?.myDjList.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    
    func numberofRows() -> Int {
        return currentMyDjRecord.count
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
        self.reduce()
    }
    
    func reduce() {
        myDjRecord
            .withUnretained(self)
            .subscribe(onNext: { owner,record in
                if owner.currentMyDjRecord.isEmpty {
                    owner.isEmpty.onNext(true)
                } else {
                    owner.isEmpty.onNext(false)
                }
            }).disposed(by: disposeBag)
        
    }
    
}
