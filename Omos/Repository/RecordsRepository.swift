//
//  RecordsRepository.swift
//  Omos
//
//  Created by sangheon on 2022/03/02.
//

import RxSwift

protocol RecordsRepository {
    init(recordAPI:RecordAPI)
    func selectRecord() -> Single<SelectResponse>
    func cateFetch(type:cateType,page:Int,size:Int,sort:String,userid:Int) -> Single<[CategoryRespone]>
    func myRecordFetch(userid:Int) -> Single<[MyRecordRespone]>
    func save(cate:String,content:String,isPublic:Bool,musicId:String,title:String,userid:Int) -> Single<SaveRespone>
   
}
