//
//  AllRecordDetailViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/03/11.
//

import Foundation
import RxSwift

class AllRecordDetailViewModel:BaseViewModel {
    
    let loading = BehaviorSubject<Bool>(value:false)
    let selectDetail = PublishSubject<DetailRecordResponse>()
    var currentSelectDetail:DetailRecordResponse? = nil
    let reportState = PublishSubject<Bool>()
    let usecase:RecordsUseCase
    let errorMessage = BehaviorSubject<String?>(value: nil)
    
    func selectDetailFetch(postId:Int,userId:Int) {
        loading.onNext(true)
        usecase.recordDetail(postId: postId, userId: userId)
            .subscribe({ [weak self] event in
                self?.loading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentSelectDetail = data
                    self?.selectDetail.onNext(data)
                case .failure(let error):
                    print(error)
                    self?.errorMessage.onNext(error.localizedDescription)
                }
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
