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
    func recordDetail(postId:Int,userId:Int) -> Single<DetailRecordResponse>
    func cateFetch(type:cateType,postId:Int?,size:Int,sort:String,userid:Int) -> Single<[CategoryRespone]>
    func myRecordFetch(userid:Int) -> Single<[MyRecordRespone]>
    func save(cate:String,content:String,isPublic:Bool,musicId:String,title:String,userid:Int,recordImageUrl:String) -> Single<SaveRespone>
    func recordIspublic(postId:Int) -> Single<StateRespone>
    func recordDelete(postId:Int) -> Single<StateRespone>
    func recordUpdate(postId:Int,request:UpdateRequest) -> Single<StateRespone>
    func oneMusicRecordFetch(musicId:String,request:OneMusicRecordRequest) -> Single<[OneMusicRecordRespone]>
    //MARK: Interaction API
    func saveScrap(postId:Int,userId:Int) -> Single<StateRespone>
    func deleteScrap(postId:Int,userId:Int) -> Single<StateRespone>
    func saveLike(postId:Int,userId:Int) -> Single<StateRespone>
    func deleteLike(postId:Int,userId:Int) -> Single<StateRespone>
    
    //MARK: mydj
    func MyDjAllRecord(userId:Int,MyDjRequest:MyDjRequest) -> Single<[MyDjResponse]>
    func saveFollow(fromId:Int,toId:Int) -> Single<StateRespone>
    func deleteFollow(fromId:Int,toId:Int) -> Single<StateRespone>
    func myDjProfile(fromId:Int,toId:Int) -> Single<MyDjProfileResponse>
    func myDjList(userId:Int) -> Single<[MyDjListResponse]>
    func userRecords(fromId:Int,toId:Int) -> Single<[MyDjResponse]>
    func reportRecord(postId:Int) -> Single<StateRespone>
    func userReport(userId:Int) -> Single<StateRespone>
    func awsDeleteImage(request:AwsDeleteImageRequest) -> Single<StateRespone>
    func blockObjcet(type:String,request:BlockRequest) -> Single<StateRespone>
}
