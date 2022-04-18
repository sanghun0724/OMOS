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

    func likeRecords(userId: Int) -> Single<[MyRecordRespone]> {
        myProfileRepository.likeRecords(userId: userId)
    }

    func scrapRecords(userId: Int) -> Single<[MyRecordRespone]> {
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
}
