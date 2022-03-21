//
//  MyProfileRepository.swift
//  Omos
//
//  Created by sangheon on 2022/03/20.
//

import Foundation
import RxSwift

protocol MyProfileRepository {
    var myProfileAPI:MyProfileAPI { get }
    init(myProfileAPI:MyProfileAPI)
    func myProfile(userId:Int) -> Single<myProfileResponse>
    func updatePassword(request:PWUpdateRequest) -> Single<StateRespone>
    func updateProfile(request:ProfileUpdateRequest) -> Single<StateRespone>
    func likeRecords(userId:Int) -> Single<[MyRecordRespone]>
    func scrapRecords(userId:Int) -> Single<[MyRecordRespone]>
    func myProfileRecord(userId:Int) -> Single<MyProfileRecordResponse>
    func logOut(userId:Int) -> Single<StateRespone>
}
