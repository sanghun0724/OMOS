//
//  MyDJViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/03/13.
//

import Foundation
import RxSwift

class MyDjViewModel: BaseViewModel {
    let cellHeight = PublishSubject<IndexPath>()
    let myDjRecord = PublishSubject<[MyDjResponse]>()
    var currentMyDjRecord: [MyDjResponse] = []
    let myDjList = PublishSubject<[MyDjListResponse]>()
    var currentMyDjList: [MyDjListResponse] = []
    let loading = PublishSubject<Bool>()
    let isEmpty = BehaviorSubject<Bool>(value: false)
    let errorMessage = BehaviorSubject<String?>(value: nil)

    let userRecords = PublishSubject<[MyDjResponse]>()
    var currentUserRecrods: [MyDjResponse] = []
    let recordsLoading = PublishSubject<Bool>()

    let reportState = PublishSubject<Bool>()
    let usecase: RecordsUseCase

    func fetchMyDjRecord(userId: Int, request: MyDjRequest) {
        loading.onNext(true)
        usecase.myDjAllRecord(userId: userId, myDjRequest: request)
            .map {
                $0.filter { !Account.currentReportRecordsId.contains($0.recordID) }
            }
            .subscribe({ [weak self] result in
                self?.loading.onNext(false)
                switch result {
                case .success(let data):
                    self?.currentMyDjRecord += data
                    self?.myDjRecord.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }

    func fetchUserRecords(fromId: Int, toId: Int) {
        recordsLoading.onNext(true)
        usecase.userRecords(fromId: fromId, toId: toId)
            .subscribe({ [weak self] event in
                self?.recordsLoading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentUserRecrods = data
                    self?.userRecords.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }

    func fetchMyDjList(userId: Int) {
        usecase.myDjList(userId: userId)
            .subscribe({ [weak self] event in
                switch event {
                case .success(let data):
                    self?.currentMyDjList = data
                    self?.myDjList.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }

    func numberofRows() -> Int {
        currentMyDjRecord.count
    }

    // Interation
    func saveScrap(postId: Int, userId: Int) {
        usecase.saveScrap(postId: postId, userId: userId)
            .subscribe({ event in
                print(event)
            }).disposed(by: disposeBag)
    }

    func deleteScrap(postId: Int, userId: Int) {
        usecase.deleteScrap(postId: postId, userId: userId)
            .subscribe({ event in
                print(event)
            }).disposed(by: disposeBag)
    }

    func saveLike(postId: Int, userId: Int) {
        usecase.saveLike(postId: postId, userId: userId)
            .subscribe({ event in
                print(event)
            }).disposed(by: disposeBag)
    }

    func deleteLike(postId: Int, userId: Int) {
        usecase.deleteLike(postId: postId, userId: userId)
            .subscribe({ event in
                print(event)
            }).disposed(by: disposeBag)
    }

    func reportRecord(postId: Int) {
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

    init(usecase: RecordsUseCase) {
        self.usecase = usecase
        super.init()
        self.reduce()
    }

    func reduce() {
        myDjRecord
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                if owner.currentMyDjRecord.isEmpty {
                    owner.isEmpty.onNext(true)
                } else {
                    owner.isEmpty.onNext(false)
                }
            }).disposed(by: disposeBag)
    }
}
