//
//  MyProfileRepositoryImpl.swift
//  Omos
//
//  Created by sangheon on 2022/03/20.
//

import Foundation
import RxSwift

class MyProfileRepositoryImpl: MyProfileRepository {
    var myProfileAPI: MyProfileAPI
    
    required init(myProfileAPI: MyProfileAPI) {
        self.myProfileAPI = myProfileAPI
    }
    
    func myProfile(userId: Int) -> Single<MyProfileResponse> {
        Single<MyProfileResponse>.create { [weak self] single in
            self?.myProfileAPI.myProfile(userId: userId, completion: { result in
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
        Single<StateRespone>.create { [weak self] single in
            self?.myProfileAPI.updatePassword(request: request, completion: { result in
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
        Single<StateRespone>.create { [weak self] single in
            self?.myProfileAPI.updateProfile(request: request, completion: { result in
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
    
    func likeRecords(userId: Int) -> Single<[MyRecordResponse]> {
        Single<[MyRecordResponse]>.create { [weak self] single in
            self?.myProfileAPI.likeRecords(userId: userId, completion: { result in
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
    
    func scrapRecords(userId: Int) -> Single<[MyRecordResponse]> {
        Single<[MyRecordResponse]>.create { [weak self] single in
            self?.myProfileAPI.scrapRecords(userId: userId, completion: { result in
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
    
    func myProfileRecord(userId: Int) -> Single<MyProfileRecordResponse> {
        Single<MyProfileRecordResponse>.create { [weak self] single in
            self?.myProfileAPI.myProfileRecords(userId: userId, completion: { result in
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
    
    func logOut(userId: Int) -> Single<StateRespone> {
        Single<StateRespone>.create { [weak self] single in
            self?.myProfileAPI.logOut(userId: userId, completion: { result in
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
    
    func myDjProfile(fromId: Int, toId: Int) -> Single<MyDjProfileResponse> {
        Single<MyDjProfileResponse>.create { [weak self] single in
            self?.myProfileAPI.myDjProfile(fromId: fromId, toId: toId, completion: { result in
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
    
    func signOut(userId: Int) -> Single<StateRespone> {
        Single<StateRespone>.create { [weak self] single in
            self?.myProfileAPI.signOut(userId: userId, completion: { result in
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
    
    func followerList(userId: Int) -> Single<[ListResponse]> {
        Single<[ListResponse]>.create { [weak self] single in
            self?.myProfileAPI.followerList(userId: userId, completion: { result in
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
    
    func followingList(userId: Int) -> Single<[ListResponse]> {
        Single<[ListResponse]>.create { [weak self] single in
            self?.myProfileAPI.followingList(userId: userId, completion: { result in
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
    
    func blockList(userId: Int) -> Single<[ListResponse]> {
        Single<[ListResponse]>.create { [weak self] single in
            self?.myProfileAPI.blockList(userId: userId, completion: { result in
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
    
    func blockDelete(targetId: Int) -> Single<StateRespone> {
        Single<StateRespone>.create { [weak self] single in
            self?.myProfileAPI.blockDelete(targetId: targetId, completion: { result in
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
    
    func saveFollow(fromId: Int, toId: Int) -> Single<StateRespone> {
        Single<StateRespone>.create { [weak self] single in
            self?.myProfileAPI.saveFollow(fromId: fromId, toId: toId, completion: { result in
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

    func deleteFollow(fromId: Int, toId: Int) -> Single<StateRespone> {
        Single<StateRespone>.create { [weak self] single in
            self?.myProfileAPI.deleteFollow(fromId: fromId, toId: toId, completion: { result in
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
