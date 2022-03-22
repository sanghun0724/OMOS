//
//  ProfileViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/03/18.
//

import Foundation
import RxSwift

class ProfileViewModel:BaseViewModel {
    
    let myProfile = PublishSubject<MyDjProfileResponse>()
    var currentMyProfile:MyDjProfileResponse? = nil
    
    let myProfileRecord = PublishSubject<MyProfileRecordResponse>()
    var currentMyProfileRecord:MyProfileRecordResponse = .init(likedRecords: [],scrappedRecords: [])
    
    let likeRecord = PublishSubject<[MyRecordRespone]>()
    var currentLikeRecord:[MyRecordRespone] = []
    let scrapRecord = PublishSubject<[MyRecordRespone]>()
    var currentScrapRecord:[MyRecordRespone] = []
    
    let logoutState = PublishSubject<Bool>()
    let updateProfileState = PublishSubject<Bool>()
    
    let allLoading = BehaviorSubject<Bool>(value:false)
    let profileLoading = BehaviorSubject<Bool>(value:false)
    let recordLoading = BehaviorSubject<Bool>(value:false)
    let likesLoading = BehaviorSubject<Bool>(value:false)
    let scrapsLoading = BehaviorSubject<Bool>(value:false)
    let isLikeEmpty = BehaviorSubject<Bool>(value:false)
    let isScrapEmpty = BehaviorSubject<Bool>(value:false)
    let errorMessage = BehaviorSubject<String?>(value: nil)
    let usecase:MyProfileUseCase
    
    func allFetch() {
        allLoading.onNext(true)
        Observable.combineLatest(profileLoading,recordLoading)
        { !($0 || $1) }
        .subscribe(onNext: { [weak self] loading in
            if loading {
                self?.allLoading.onNext(false)
            }
        }).disposed(by: disposeBag)
        
        fetchMyProfile(userId: Account.currentUser)
        fetchMyProfileRecords(userId: Account.currentUser)
    }
    
    
    func fetchMyProfile(userId:Int) {
        profileLoading.onNext(true)
        usecase.myDjProfile(fromId: userId, toId: userId)
            .subscribe({ [weak self] event in
                self?.profileLoading.onNext(false)
                switch event {
                case .success(let data):
                    print(data)
                    self?.currentMyProfile = data
                    self?.myProfile.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    func fetchMyProfileRecords(userId:Int) {
        recordLoading.onNext(true)
        usecase.myProfileRecord(userId: userId)
            .subscribe({ [weak self] event in
                self?.recordLoading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentMyProfileRecord = data
                    self?.myProfileRecord.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    func fetchLikesRecords(userId:Int) {
        likesLoading.onNext(true)
        usecase.likeRecords(userId: userId)
            .subscribe({ [weak self] event in
                self?.likesLoading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentLikeRecord = data
                    self?.likeRecord.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    func fetchScrapRecords(userId:Int) {
        scrapsLoading.onNext(true)
        usecase.scrapRecords(userId: userId)
            .subscribe({ [weak self] event in
                self?.scrapsLoading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentScrapRecord = data
                    self?.scrapRecord.onNext(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    func updatePassword(request:PWUpdateRequest) {
        usecase.updatePassword(request:request)
            .subscribe({ [weak self] event in
                switch event {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    
    }
    
    func updateProfile(request:ProfileUpdateRequest) {
        usecase.updateProfile(request: request)
            .subscribe({ [weak self] event in
                switch event {
                case .success(let data):
                    self?.updateProfileState.onNext(data.state)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    func logOut(userId:Int) {
        usecase.logOut(userId: userId)
            .subscribe({ [weak self] event in
                switch event {
                case .success(let data):
                    self?.logoutState.onNext(data.state)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    init(usecase:MyProfileUseCase) {
        self.usecase = usecase
        super.init()
      
    }
    
}
