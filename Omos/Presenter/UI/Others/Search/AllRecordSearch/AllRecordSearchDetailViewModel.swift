//
//  AllRecordSearchDetailViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/03/09.
//

import Foundation
import RxSwift

class AllRecordSearchDetailViewModel: BaseViewModel {
    let recentFilter = PublishSubject<Bool>()
    let likeFilter = PublishSubject<Bool>()
    let randomFilter = PublishSubject<Bool>()
    let loading = BehaviorSubject<Bool>(value: false)
    let oneMusicRecords = PublishSubject<[OneMusicRecordRespone]>()
    var currentOneMusicRecords: [OneMusicRecordRespone] = []
    let reportState = PublishSubject<Bool>()
    let errorMessage = BehaviorSubject<String?>(value: nil)
    let isEmpty = BehaviorSubject<Bool>(value: false)
    let usecase: RecordsUseCase

    func oneMusicRecordsFetch(musicId: String, request: OneMusicRecordRequest) {
        loading.onNext(true)
        usecase.oneMusicRecordFetch(musicId: musicId, request: request)
            .map {
                $0.filter { !Account.currentReportRecordsId.contains($0.recordID) }
            }
            .subscribe({ [weak self] event in
                self?.loading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentOneMusicRecords += data
                    self?.oneMusicRecords.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                    self?.oneMusicRecords.onNext([])
                }
            }).disposed(by: disposeBag)
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
        oneMusicRecords
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                if owner.currentOneMusicRecords.isEmpty {
                    owner.isEmpty.onNext(true)
                } else {
                    owner.isEmpty.onNext(false)
                }
            }).disposed(by: disposeBag)
    }
}
