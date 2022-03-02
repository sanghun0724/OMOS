//
//  RecordsUseCase.swift
//  Omos
//
//  Created by sangheon on 2022/03/02.
//

import Foundation
import RxSwift

class RecordsUseCase {
    
    private let recordsRepository:RecordsRepository
    
    init(recordsRepository:RecordsRepository) {
        self.recordsRepository = recordsRepository
    }
    
    func selectRecord() -> Single<SelectResponse> {
        return recordsRepository.selectRecord()
    }
    
    
    
    
    
}
