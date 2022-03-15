//
//  TodayRepositoryImpl.swift
//  Omos
//
//  Created by sangheon on 2022/03/15.
//

import Foundation
import RxSwift

class TodayRepositoryImpl:TodayRepository {
    var todayAPI: TodayAPI
    
    required init(todayAPI: TodayAPI) {
        self.todayAPI = todayAPI
    }
    
    func popuralRecord() -> Single<[PopuralResponse]> {
        return Single<[PopuralResponse]>.create { [weak self] single in
            self?.todayAPI.popuralRecord( completion: { result in
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
    
    func lovedRecord() -> Single<LovedResponse> {
        return Single<LovedResponse>.create { [weak self] single in
            self?.todayAPI.lovedRecord( completion: { result in
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
    
    func recommendDJRecord() -> Single<[recommendDjResponse]> {
        return Single<[recommendDjResponse]>.create { [weak self] single in
            self?.todayAPI.recommedRecord( completion: { result in
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
    
    func todayRecord() -> Single<TodayTrackResponse> {
        return Single<TodayTrackResponse>.create { [weak self] single in
            self?.todayAPI.todayTrackRecord ( completion: { result in
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
