//
//  CreateViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/02/20.
//

import Foundation
import RxSwift

class CreateViewModel: BaseViewModel {
    let curTime = "\(Account.currentUser)\(Date.currentTimeStamp)"
    var modifyDefaultModel: DetailRecordResponse?
    var defaultModel: RecordSaveDefaultModel = .init(musicId: "", imageURL: "", musicTitle: "", subTitle: "") // create할때 있는놈들
    let errorMessage = BehaviorSubject<String?>(value: nil)
    let loading = BehaviorSubject<Bool>(value: false)
    let state = PublishSubject<Bool>()
    var currentState: Bool = true
    let usecase: RecordsUseCase

    init(usecase: RecordsUseCase) {
        self.usecase = usecase
        super.init()
    }

    func saveRecord(cate: String, content: String, isPublic: Bool, musicId: String, title: String, userid: Int, recordImageURL: String) {
        loading.onNext(false)
        usecase.save(cate: cate, content: content, isPublic: isPublic, musicId: musicId, title: title, userid: userid, recordImageUrl: recordImageURL)
            .subscribe({ [weak self] event in
                self?.loading.onNext(true)
                switch event {
                case .success(let data):
                    self?.currentState = data.state
                    self?.state.onNext(data.state)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }

    func updateRecord(postId: Int, request: UpdateRequest) {
        usecase.recordUpdate(postId: postId, request: request)
            .subscribe({ [weak self] event in
                self?.loading.onNext(true)
                switch event {
                case .success:
                    self?.currentState = true
                    self?.state.onNext(true)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
}
