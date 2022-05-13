//
//  MyRecordDetailViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/03/10.
//

import Foundation
import RxSwift

class MyRecordDetailViewModel: BaseViewModel {
    let myRocordDetail = PublishSubject<DetailRecordResponse>()
    var currentMyRecordDetail: DetailRecordResponse?
    let delete = PublishSubject<Bool>()
    let modify = PublishSubject<Bool>()
    let done = PublishSubject<Bool>()
    let loading = BehaviorSubject<Bool>(value: false)
    var recordData: MyRecordResponse?
    let usecase: RecordsUseCase
    let errorMessage = BehaviorSubject<String?>(value: nil)

    func myRecordDetailFetch(postId: Int, userId: Int) {
        loading.onNext(true)
        usecase.recordDetail(postId: postId, userId: userId)
            .subscribe({ [weak self] event in
                self?.loading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentMyRecordDetail = data
                    self?.myRocordDetail.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }

    func deleteRecord(postId: Int) {
        usecase.recordDelete(postId: postId)
            .subscribe({ [weak self] _ in
                self?.done.onNext(true)
            }).disposed(by: disposeBag)
    }

    func awsDeleteImage(request: AwsDeleteImageRequest) {
        usecase.awsDeleteImage(request: request)
            .subscribe({ [weak self] event in
                switch event {
                case .success(let state):
                    print("is delted Image? \(state)")
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
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

    init(usecase: RecordsUseCase) {
        self.usecase = usecase
        super.init()
    }
}
