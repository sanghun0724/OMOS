//
//  RecordsRepository.swift
//  Omos
//
//  Created by sangheon on 2022/03/02.
//

import RxSwift

protocol RecordsRepository {
    func selectRecord() -> Single<SelectResponse>
    func cateFetch(type:cateType,page:Int,size:Int,sort:String,userid:Int) -> Single<[CategoryRespone]>
}
