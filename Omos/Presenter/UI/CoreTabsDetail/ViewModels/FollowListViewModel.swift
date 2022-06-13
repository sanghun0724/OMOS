//
//  FollowListViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/05/31.
//

import Foundation
import RxSwift

class FollowListViewModel: BaseViewModel {
    let followerList = PublishSubject<[ListResponse]>()
    var currentFollowerList: [ListResponse] = []
    let followingList = PublishSubject<[ListResponse]>()
    var currentFollowingList: [ListResponse] = []
    let blockList = PublishSubject<[ListResponse]>()
    var currentBlockList: [ListResponse] = []
    
    let isEmpty = BehaviorSubject<Bool>(value: false)
    let isLoading = BehaviorSubject<Bool>(value: false)
    let usecase: MyProfileUseCase
    let errorMessage = BehaviorSubject<String?>(value: nil)
    
    func fetchFollowerList(userId: Int) {
        isLoading.onNext(true)
        usecase.followerList(userId: userId)
            .subscribe({ [weak self] event in
                self?.isLoading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentFollowerList = data
                    self?.followerList.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    func fetchFollowingList(userId: Int) {
        isLoading.onNext(true)
        usecase.followingList(userId: userId)
            .subscribe({ [weak self] event in
                self?.isLoading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentFollowingList = data
                    self?.followingList.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    func fetchBlockList(userId: Int) {
        isLoading.onNext(true)
        usecase.blockList(userId: userId)
            .subscribe({ [weak self] event in
                self?.isLoading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentBlockList = data
                    self?.blockList.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    // follow
    func saveFollow(fromId: Int, toId: Int) {
        usecase.saveFollow(fromId: fromId, toId: toId)
            .subscribe({ state in
                print(state)
        NotificationCenter.default.post(name: NSNotification.Name.follow, object: nil, userInfo: nil)
            }).disposed(by: disposeBag)
    }

    func deleteFollow(fromId: Int, toId: Int) {
        usecase.deleteFollow(fromId: fromId, toId: toId)
            .subscribe({ state in
                print(state)
        NotificationCenter.default.post(name: NSNotification.Name.followCancel, object: nil, userInfo: nil)
            }).disposed(by: disposeBag)
    }
    
    func deleteBlock(targetId:Int) {
        usecase.blockDelete(targetId: targetId)
            .subscribe({ state in
                print(state)
            }).disposed(by: disposeBag)
        //MARK: notification add--
    }
    
    
    
    init(usecase: MyProfileUseCase) {
        self.usecase = usecase
    }
}
