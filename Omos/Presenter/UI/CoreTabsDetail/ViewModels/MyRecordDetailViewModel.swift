//
//  MyRecordDetailViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/03/10.
//

import Foundation

class MyRecordDetailViewModel:BaseViewModel {
    
    var recordData:MyRecordRespone? = nil
    let usecase:RecordsUseCase
    
    
    
    init(usecase:RecordsUseCase) {
        self.usecase = usecase
        super.init()
    }
    
}
