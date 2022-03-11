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
    
    func selectDetail(postId:Int,userId:Int) -> Single<SelectDetailRespone> {
        return Single<SelectDetailRespone>.create { [weak self] single in
            self?.recordAPI.selectDetail(postId: postId, userId: userId, completion: { result in
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
    
    func recordUpdate(postId:Int,request:UpdateRequest) -> Single<PostRespone> {
        return Single<PostRespone>.create { [weak self] single in
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
    
    
}
