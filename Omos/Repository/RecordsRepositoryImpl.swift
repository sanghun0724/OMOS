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
    
    
    
    
    
    
    
    
}
