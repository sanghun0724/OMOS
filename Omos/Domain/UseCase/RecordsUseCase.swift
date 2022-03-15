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
    
    func recordDetail(postId:Int,userId:Int) -> Single<DetailRecordResponse> {
        return recordsRepository.recordDetail(postId: postId, userId: userId)
    }
    
    func cateFetch(type:cateType,postId:Int?,size:Int,sort:String,userid:Int) -> Single<[CategoryRespone]> {
        return recordsRepository.cateFetch(type:type,postId:postId,size:size,sort:sort,userid:userid)
    }
    
    func myRecordFetch(userid:Int) -> Single<[MyRecordRespone]> {
        return recordsRepository.myRecordFetch(userid: userid)
    }
    
    func save(cate:String,content:String,isPublic:Bool,musicId:String,title:String,userid:Int) -> Single<SaveRespone> {
        return recordsRepository.save(cate: cate, content: content, isPublic: isPublic, musicId: musicId, title: title, userid: userid)
    }
    
    func recordIspublic(postId:Int) -> Single<StateRespone> {
        return recordsRepository.recordIspublic(postId: postId)
    }
    
    func recordDelete(postId:Int) -> Single<StateRespone> {
        return recordsRepository.recordDelete(postId: postId)
    }
    
    func recordUpdate(postId:Int,request:UpdateRequest) -> Single<PostRespone> {
        return recordsRepository.recordUpdate(postId: postId,request:request)
    }
    
    func oneMusicRecordFetch(musicId:String,request:OneMusicRecordRequest) -> Single<[OneMusicRecordRespone]> {
        return recordsRepository.oneMusicRecordFetch(musicId: musicId, request: request)
    }
    
    //MARK: Interaction API
    func saveScrap(postId:Int,userId:Int) -> Single<StateRespone> {
        return recordsRepository.saveScrap(postId: postId, userId: userId)
    }
    
    func deleteScrap(postId:Int,userId:Int) -> Single<StateRespone> {
        return recordsRepository.deleteScrap(postId: postId, userId: userId)
    }
    
    func saveLike(postId:Int,userId:Int) -> Single<StateRespone> {
        return recordsRepository.saveLike(postId: postId, userId: userId)
    }
    
    func deleteLike(postId:Int,userId:Int) -> Single<StateRespone> {
        return recordsRepository.deleteLike(postId: postId, userId: userId)
    }
    
    //MARK: Mydj
    func MyDjAllRecord(userId:Int,MyDjRequest:MyDjRequest) -> Single<[MyDjResponse]> {
        return recordsRepository.MyDjAllRecord(userId: userId, MyDjRequest: MyDjRequest)
    }
    
    func saveFollow(fromId:Int,toId:Int) -> Single<StateRespone> {
        return recordsRepository.saveFollow(fromId: fromId, toId: toId)
    }
     
    func deleteFollow(fromId:Int,toId:Int) -> Single<StateRespone> {
        return recordsRepository.deleteFollow(fromId: fromId, toId: toId)
    }
    
    func myDjProfile(fromId:Int,toId:Int) -> Single<MyDjProfileResponse> {
        return recordsRepository.myDjProfile(fromId: fromId, toId: toId)
    }
    
    func myDjList(userId:Int) -> Single<[MyDjListResponse]> {
        return recordsRepository.myDjList(userId: userId)
    }
    
    func userRecords(fromId:Int,toId:Int) -> Single<[UserRecordsResponse]> {
        return recordsRepository.userRecords(fromId: fromId, toId: toId)
    }
}
