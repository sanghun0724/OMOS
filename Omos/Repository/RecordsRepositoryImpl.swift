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
    
    init(recordAPI:RecordAPI) {
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
    
    
    func cateFetch(type: cateType, page: Int, size: Int, sort: String, userid: Int) -> Single<[CategoryRespone]> {
        return Single<[CategoryRespone]>.create { [weak self] single in
            self?.recordAPI.categoryFetch(cateType: type, request: .init(page: page, size: size, sort: sort, userid: userid), completion: { result in
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
    
    
    
    
    
}
