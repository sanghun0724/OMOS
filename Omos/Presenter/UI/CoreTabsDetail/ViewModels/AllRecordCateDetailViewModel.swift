//
//  AllRecordDetailViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/03/03.
//

import Foundation
import RxSwift



class AllRecordCateDetailViewModel:BaseViewModel {
    
    let recentFilter = PublishSubject<Bool>()
    let likeFilter = PublishSubject<Bool>()
    let randomFilter = PublishSubject<Bool>()
    let loading = BehaviorSubject<Bool>(value:false)
    let cateRecords = BehaviorSubject<[CategoryRespone]>(value: [])
    var currentCateRecords:[CategoryRespone] = []
    let reportState = PublishSubject<Bool>()
    let errorMessage = BehaviorSubject<String?>(value: nil)
    let usecase:RecordsUseCase
    
    
    func selectRecordsShow(type: cateType, postId: Int?, size: Int, sort: String, userid: Int) {
        loading.onNext(true)
        usecase.cateFetch(type: type, postId: postId, size: size, sort: sort, userid: userid)
            .subscribe({ [weak self] event in
                self?.loading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentCateRecords += data
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
    
    func reportRecord(postId:Int) {
        usecase.reportRecord(postId: postId)
            .subscribe({ [weak self] event in
                switch event {
                case .success(let data):
                    self?.reportState.onNext(data.state)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    
    init(usecase:RecordsUseCase) {
        self.usecase = usecase
        super.init()
    }
    
    
}
