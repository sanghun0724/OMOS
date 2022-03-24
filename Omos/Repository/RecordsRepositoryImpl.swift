//
//  RecordsRepositoryImpl.swift
//  Omos
//
//  Created by sangheon on 2022/03/02.
//

import Foundation
import RxSwift

class RecordsRepositoryImpl:RecordsRepository {
    
    let disposeBag = DisposeBag()
    private let recordAPI:RecordAPI
    
    required init(recordAPI:RecordAPI) {
        self.recordAPI = recordAPI
    }
    
    func selectRecord() -> Single<SelectResponse> {
        return Single<SelectResponse>.create { [weak self] single in
            self?.recordAPI.select { result in
                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
    
    func recordDetail(postId:Int,userId:Int) -> Single<DetailRecordResponse> {
        return Single<DetailRecordResponse>.create { [weak self] single in
            self?.recordAPI.recordDetail(postId: postId, userId: userId, completion: { result in
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
    
    
    func cateFetch(type: cateType, postId: Int?, size: Int, sort: String, userid: Int) -> Single<[CategoryRespone]> {
        return Single<[CategoryRespone]>.create { [weak self] single in
            self?.recordAPI.categoryFetch(cateType: type, request: .init(postId: postId, size: size, sortType: sort, userid: userid), completion: { result in
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
    
    func myRecordFetch(userid: Int) -> Single<[MyRecordRespone]> {
        return Single<[MyRecordRespone]>.create { [weak self] single in
            self?.recordAPI.myRecordFetch(userid:userid ,completion: { result in
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
    
    func save(cate: String, content: String, isPublic: Bool, musicId: String, title: String, userid: Int) -> Single<SaveRespone> {
        
        return Single<SaveRespone>.create { [weak self] single in
            self?.recordAPI.saveFetch(request:.init(category: cate, isPublic: isPublic, musicID: musicId, recordContents: content, recordImageURL: "", recordTitle: title, userID: userid) ,completion: { result in
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
    
    func recordIspublic(postId:Int) -> Single<StateRespone> {
        return Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.recordIspublic(postId: postId ,completion: { result in
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
    
    func recordDelete(postId:Int) -> Single<StateRespone> {
        return Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.recordDelete(postId: postId ,completion: { result in
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
    
    func recordUpdate(postId:Int,request:UpdateRequest) -> Single<StateRespone> {
        return Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.recordUpdate(postId: postId,request:request,completion: { result in
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
    
    func oneMusicRecordFetch(musicId:String,request:OneMusicRecordRequest) -> Single<[OneMusicRecordRespone]> {
        return Single<[OneMusicRecordRespone]>.create { [weak self] single in
            self?.recordAPI.oneMusicRecordFetch(musicId: musicId, request: request ,completion: { result in
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
    
    func saveScrap(postId:Int,userId:Int) -> Single<StateRespone> {
        return Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.saveScrap(postId: postId, userId: userId,completion: { result in
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
    
    func deleteScrap(postId:Int,userId:Int) -> Single<StateRespone> {
        return Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.deleteScrap(postId: postId, userId: userId,completion: { result in
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
    
    func saveLike(postId:Int,userId:Int) -> Single<StateRespone> {
        return Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.saveLike(postId: postId, userId: userId,completion: { result in
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
    
    func deleteLike(postId:Int,userId:Int) -> Single<StateRespone> {
        return Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.deleteLike(postId: postId, userId: userId,completion: { result in
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
    
    func MyDjAllRecord(userId:Int,MyDjRequest:MyDjRequest) -> Single<[MyDjResponse]> {
        return Single<[MyDjResponse]>.create { [weak self] single in
            self?.recordAPI.MyDjAllRecord(userId: userId, MyDjRequest: MyDjRequest ,completion: { result in
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
//    func MyDjAllRecord(userId:Int,MyDjRequest:MyDjRequest) -> Single<[MyDjResponse]>
//    func saveFollow(fromId:Int,toId:Int) -> Single<StateRespone>
//    func deleteFollow(fromId:Int,toId:Int) -> Single<StateRespone>
//    func myDjProfile(fromId:Int,toId:Int) -> Single<MyDjProfileResponse>
//    func myDjList(userId:Int) -> Single<[MyDjListResponse]>
    
    func saveFollow(fromId:Int,toId:Int) -> Single<StateRespone> {
        return Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.saveFollow(fromId: fromId, toId: toId ,completion: { result in
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
    
    func deleteFollow(fromId:Int,toId:Int) -> Single<StateRespone> {
        return Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.deleteFollow(fromId: fromId, toId: toId ,completion: { result in
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
            self?.recordAPI.myDjProfile(fromId: fromId, toId: toId ,completion: { result in
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
    
    func myDjList(userId:Int) -> Single<[MyDjListResponse]> {
        return Single<[MyDjListResponse]>.create { [weak self] single in
            self?.recordAPI.myDjList(userId: userId ,completion: { result in
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
    
    func userRecords(fromId:Int,toId:Int) -> Single<[MyDjResponse]> {
        return Single<[MyDjResponse]>.create { [weak self] single in
            self?.recordAPI.userRecords(fromId: fromId, toId: toId ,completion: { result in
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
    
    func reportRecord(postId:Int) -> Single<StateRespone> {
        return Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.reportRecord(postId: postId,completion: { result in
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
