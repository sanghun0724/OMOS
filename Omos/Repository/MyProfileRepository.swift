//
//  MyProfileRepository.swift
//  Omos
//
//  Created by sangheon on 2022/03/20.
//

import Foundation
import RxSwift

protocol MyProfileRepository {
    var myProfileAPI: MyProfileAPI { get }
    init(myProfileAPI: MyProfileAPI)
    func myProfile(userId: Int) -> Single<MyProfileResponse>
    func updatePassword(request: PWUpdateRequest) -> Single<StateRespone>
    func updateProfile(request: ProfileUpdateRequest) -> Single<StateRespone>
    func likeRecords(userId: Int) -> Single<[MyRecordResponse]>
    func scrapRecords(userId: Int) -> Single<[MyRecordResponse]>
    func myProfileRecord(userId: Int) -> Single<MyProfileRecordResponse>
    func logOut(userId: Int) -> Single<StateRespone>
    func myDjProfile(fromId: Int, toId: Int) -> Single<MyDjProfileResponse>
    func signOut(userId: Int) -> Single<StateRespone>
}
