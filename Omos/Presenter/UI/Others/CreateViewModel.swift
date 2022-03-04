//
//  CreateViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/02/20.
//

import Foundation
import RxSwift

class CreateViewModel:BaseViewModel {
    let errorMessage = BehaviorSubject<String?>(value: nil)
    let loading = BehaviorSubject<Bool>(value:false)
    let postID = PublishSubject<Int>()
    var currnetPostID = 0
    let usecase:RecordsUseCase
    
    init(usecase:RecordsUseCase) {
        self.usecase = usecase
        super.init()
        
    }
    
    func saveRecord(cate:String, content:String, isPublic:Bool, musicId: String, title: String, userid: Int) {
        loading.onNext(false)
        usecase.save(cate: cate, content: content, isPublic: isPublic, musicId: musicId, title: title, userid: userid)
            .subscribe({ [weak self] event in
                self?.loading.onNext(true)
                switch event {
                case .success(let data):
                    self?.currnetPostID = data.postID
                    self?.postID.onNext(data.postID)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    
    
}
