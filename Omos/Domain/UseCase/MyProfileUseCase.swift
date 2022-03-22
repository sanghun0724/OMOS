//
//  MyProfileUseCase.swift
//  Omos
//
//  Created by sangheon on 2022/03/20.
//

import Foundation
import RxSwift

class MyProfileUseCase {
    private let myProfileRepository:MyProfileRepository
    
    init(myProfileRepository:MyProfileRepository) {
        self.myProfileRepository = myProfileRepository
    }
    
    func myProfile(userId:Int) -> Single<myProfileResponse> {
        return myProfileRepository.myProfile(userId: userId)
    }
    
    func updatePassword(request:PWUpdateRequest) -> Single<StateRespone> {
        return myProfileRepository.updatePassword(request: request)
    }
    
    func updateProfile(request:ProfileUpdateRequest) -> Single<StateRespone> {
        return myProfileRepository.updateProfile(request: request)
    }
    
    func likeRecords(userId:Int) -> Single<[MyRecordRespone]> {
        return myProfileRepository.likeRecords(userId: userId)
    }
    
    func scrapRecords(userId:Int) -> Single<[MyRecordRespone]> {
        return myProfileRepository.scrapRecords(userId: userId)
    }
    
    func myProfileRecord(userId:Int) -> Single<MyProfileRecordResponse> {
        return myProfileRepository.myProfileRecord(userId: userId)
    }
    
    func logOut(userId:Int) -> Single<StateRespone> {
        return myProfileRepository.logOut(userId: userId)
    }
    
    func myDjProfile(fromId:Int,toId:Int) -> Single<MyDjProfileResponse> {
        return myProfileRepository.myDjProfile(fromId: fromId, toId: toId)
    }
    
}
