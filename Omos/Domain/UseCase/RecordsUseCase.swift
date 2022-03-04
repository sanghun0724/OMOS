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
    
    func cateFetch(type:cateType,page:Int,size:Int,sort:String,userid:Int) -> Single<[CategoryRespone]> {
        return recordsRepository.cateFetch(type:type,page:page,size:size,sort:sort,userid:userid)
    }
    
    func myRecordFetch(userid:Int) -> Single<[MyRecordRespone]> {
        return recordsRepository.myRecordFetch(userid: userid)
    }
    
    func save(cate:String,content:String,isPublic:Bool,musicId:String,title:String,userid:Int) -> Single<SaveRespone> {
        return recordsRepository.save(cate: cate, content: content, isPublic: isPublic, musicId: musicId, title: title, userid: userid)
    }
    
}
