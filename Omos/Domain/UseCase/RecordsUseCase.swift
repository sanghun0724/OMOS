//
//  RecordsUseCase.swift
//  Omos
//
//  Created by sangheon on 2022/03/02.
//

import Foundation
import RxSwift

class RecordsUseCase {
    private let recordsRepository: RecordsRepository

    init(recordsRepository: RecordsRepository) {
        self.recordsRepository = recordsRepository
    }

    func selectRecord() -> Single<SelectResponse> {
        recordsRepository.selectRecord()
    }

    func recordDetail(postId: Int, userId: Int) -> Single<DetailRecordResponse> {
        recordsRepository.recordDetail(postId: postId, userId: userId)
    }

    func cateFetch(type: CateType, postId: Int?, size: Int, sort: String, userid: Int) -> Single<[CategoryRespone]> {
        recordsRepository.cateFetch(type: type, postId: postId, size: size, sort: sort, userid: userid)
    }

    func myRecordFetch(userid: Int) -> Single<[MyRecordRespone]> {
        recordsRepository.myRecordFetch(userid: userid)
    }

    func save(cate: String, content: String, isPublic: Bool, musicId: String, title: String, userid: Int, recordImageUrl: String) -> Single<SaveRespone> {
        recordsRepository.save(cate: cate, content: content, isPublic: isPublic, musicId: musicId, title: title, userid: userid, recordImageUrl: recordImageUrl)
    }

    func recordIspublic(postId: Int) -> Single<StateRespone> {
        recordsRepository.recordIspublic(postId: postId)
    }

    func recordDelete(postId: Int) -> Single<StateRespone> {
        recordsRepository.recordDelete(postId: postId)
    }

    func recordUpdate(postId: Int, request: UpdateRequest) -> Single<StateRespone> {
        recordsRepository.recordUpdate(postId: postId, request: request)
    }

    func oneMusicRecordFetch(musicId: String, request: OneMusicRecordRequest) -> Single<[OneMusicRecordRespone]> {
        recordsRepository.oneMusicRecordFetch(musicId: musicId, request: request)
    }

    // MARK: Interaction API
    func saveScrap(postId: Int, userId: Int) -> Single<StateRespone> {
        recordsRepository.saveScrap(postId: postId, userId: userId)
    }

    func deleteScrap(postId: Int, userId: Int) -> Single<StateRespone> {
        recordsRepository.deleteScrap(postId: postId, userId: userId)
    }

    func saveLike(postId: Int, userId: Int) -> Single<StateRespone> {
        recordsRepository.saveLike(postId: postId, userId: userId)
    }

    func deleteLike(postId: Int, userId: Int) -> Single<StateRespone> {
        recordsRepository.deleteLike(postId: postId, userId: userId)
    }

    // MARK: Mydj
    func myDjAllRecord(userId: Int, myDjRequest: MyDjRequest) -> Single<[MyDjResponse]> {
        recordsRepository.myDjAllRecord(userId: userId, MyDjRequest: MyDjRequest)
    }

    func saveFollow(fromId: Int, toId: Int) -> Single<StateRespone> {
        recordsRepository.saveFollow(fromId: fromId, toId: toId)
    }

    func deleteFollow(fromId: Int, toId: Int) -> Single<StateRespone> {
        recordsRepository.deleteFollow(fromId: fromId, toId: toId)
    }

    func myDjProfile(fromId: Int, toId: Int) -> Single<MyDjProfileResponse> {
        recordsRepository.myDjProfile(fromId: fromId, toId: toId)
    }

    func myDjList(userId: Int) -> Single<[MyDjListResponse]> {
        recordsRepository.myDjList(userId: userId)
    }

    func userRecords(fromId: Int, toId: Int) -> Single<[MyDjResponse]> {
        recordsRepository.userRecords(fromId: fromId, toId: toId)
    }

    func reportRecord(postId: Int) -> Single<StateRespone> {
        recordsRepository.reportRecord(postId: postId)
    }

    func userReport(userId: Int) -> Single<StateRespone> {
        recordsRepository.userReport(userId: userId)
    }

    func awsDeleteImage(request: AwsDeleteImageRequest) -> Single<StateRespone> {
        recordsRepository.awsDeleteImage(request: request)
    }

    func blockObjcet(type: String, request: BlockRequest) -> Single<StateRespone> {
        recordsRepository.blockObjcet(type: type, request: request)
    }
}
