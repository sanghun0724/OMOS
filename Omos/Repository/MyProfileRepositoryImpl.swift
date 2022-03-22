//
//  MyProfileRepositoryImpl.swift
//  Omos
//
//  Created by sangheon on 2022/03/20.
//

import Foundation
import RxSwift

class MyProfileRepositoryImpl:MyProfileRepository {
    var myProfileAPI: MyProfileAPI
    
    required init(myProfileAPI: MyProfileAPI) {
        self.myProfileAPI = myProfileAPI
    }
    
    func myProfile(userId: Int) -> Single<myProfileResponse> {
        return Single<myProfileResponse>.create { [weak self] single in
            self?.myProfileAPI.myProfile(userId:userId,completion: { result in
                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            })
            
            return Disposables.create()
        }
    }
    
    func updatePassword(request: PWUpdateRequest) -> Single<StateRespone> {
        return Single<StateRespone>.create { [weak self] single in
            self?.myProfileAPI.updatePassword(request: request,completion: { result in
                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            })
            
            return Disposables.create()
        }
    }
    
    func updateProfile(request: ProfileUpdateRequest) -> Single<StateRespone> {
        return Single<StateRespone>.create { [weak self] single in
            self?.myProfileAPI.updateProfile(request: request,completion: { result in
                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            })
            
            return Disposables.create()
        }
    }
    
    func likeRecords(userId:Int) -> Single<[MyRecordRespone]> {
        return Single<[MyRecordRespone]>.create { [weak self] single in
            self?.myProfileAPI.likeRecords(userId:userId,completion: { result in
                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            })
            
            return Disposables.create()
        }
    }
    
    
    func scrapRecords(userId:Int) -> Single<[MyRecordRespone]> {
        return Single<[MyRecordRespone]>.create { [weak self] single in
            self?.myProfileAPI.scrapRecords(userId:userId,completion: { result in
                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            })
            
            return Disposables.create()
        }
    }
    
    func myProfileRecord(userId:Int) -> Single<MyProfileRecordResponse> {
        return Single<MyProfileRecordResponse>.create { [weak self] single in
            self?.myProfileAPI.myProfileRecords(userId: userId,completion: { result in
                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            })
            
            return Disposables.create()
        }
    }
    
    func logOut(userId:Int) -> Single<StateRespone> {
        return Single<StateRespone>.create { [weak self] single in
            self?.myProfileAPI.logOut(userId: userId,completion: { result in
                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            })
            
            return Disposables.create()
        }
    }
    
    func myDjProfile(fromId:Int,toId:Int) -> Single<MyDjProfileResponse> {
        return Single<MyDjProfileResponse>.create { [weak self] single in
            self?.myProfileAPI.myDjProfile(fromId: fromId, toId: toId ,completion: { result in
                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            })
            return Disposables.create()
        }
    }

}
