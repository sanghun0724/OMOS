//
//  MyProfileUseCase.swift
//  Omos
//
//  Created by sangheon on 2022/03/20.
//

import Foundation
import RxSwift

class MyProfileUseCase {
    private let myProfileRepository: MyProfileRepository

    init(myProfileRepository: MyProfileRepository) {
        self.myProfileRepository = myProfileRepository
    }

    func myProfile(userId: Int) -> Single<MyProfileResponse> {
        myProfileRepository.myProfile(userId: userId)
    }

    func updatePassword(request: PWUpdateRequest) -> Single<StateRespone> {
        myProfileRepository.updatePassword(request: request)
    }

    func updateProfile(request: ProfileUpdateRequest) -> Single<StateRespone> {
        myProfileRepository.updateProfile(request: request)
    }

    func likeRecords(userId: Int) -> Single<[MyRecordResponse]> {
        myProfileRepository.likeRecords(userId: userId)
    }

    func scrapRecords(userId: Int) -> Single<[MyRecordResponse]> {
        myProfileRepository.scrapRecords(userId: userId)
    }

    func myProfileRecord(userId: Int) -> Single<MyProfileRecordResponse> {
        myProfileRepository.myProfileRecord(userId: userId)
    }

    func logOut(userId: Int) -> Single<StateRespone> {
        myProfileRepository.logOut(userId: userId)
    }

    func myDjProfile(fromId: Int, toId: Int) -> Single<MyDjProfileResponse> {
        myProfileRepository.myDjProfile(fromId: fromId, toId: toId)
    }

    func signOut(userId: Int) -> Single<StateRespone> {
        myProfileRepository.signOut(userId: userId)
    }
    
    func followerList(userId: Int) -> Single<[ListResponse]> {
        myProfileRepository.followerList(userId: userId)
    }
    
    func followingList(userId: Int) -> Single<[ListResponse]> {
        myProfileRepository.followingList(userId: userId)
    }
    
    func blockList(userId: Int) -> Single<[ListResponse]> {
        myProfileRepository.blockList(userId: userId)
    }
    
    func blockDelete(targetId: Int) -> Single<StateRespone> {
        myProfileRepository.blockDelete(targetId: targetId)
    }
    
    func saveFollow(fromId: Int, toId: Int) -> Single<StateRespone> {
        myProfileRepository.saveFollow(fromId: fromId, toId: toId)
    }

    func deleteFollow(fromId: Int, toId: Int) -> Single<StateRespone> {
        myProfileRepository.deleteFollow(fromId: fromId, toId: toId)
    }
}
