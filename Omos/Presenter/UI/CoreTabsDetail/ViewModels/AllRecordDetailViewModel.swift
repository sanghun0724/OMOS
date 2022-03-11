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
    let selectDetail = PublishSubject<SelectDetailRespone>()
    var currentSelectDetail:SelectDetailRespone? = nil
    let usecase:RecordsUseCase
    let errorMessage = BehaviorSubject<String?>(value: nil)
    
    func selectDetailFetch(postId:Int,userId:Int) {
        loading.onNext(true)
        usecase.selectDetail(postId: postId, userId: userId)
            .subscribe({ [weak self] event in
                self?.loading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentSelectDetail = data
                    self?.selectDetail.onNext(data)
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
