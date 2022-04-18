//
//  RecordsRepositoryImpl.swift
//  Omos
//
//  Created by sangheon on 2022/03/02.
//

import Foundation
import RxSwift

class RecordsRepositoryImpl: RecordsRepository {
    let disposeBag = DisposeBag()
    private let recordAPI: RecordAPI

    required init(recordAPI: RecordAPI) {
        self.recordAPI = recordAPI
    }

    func selectRecord() -> Single<SelectResponse> {
        Single<SelectResponse>.create { [weak self] single in
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

    func recordDetail(postId: Int, userId: Int) -> Single<DetailRecordResponse> {
        Single<DetailRecordResponse>.create { [weak self] single in
            self?.recordAPI.recordDetail(postId: postId, userId: userId, completion: { result in
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

    func cateFetch(type: CateType, postId: Int?, size: Int, sort: String, userid: Int) -> Single<[CategoryRespone]> {
        Single<[CategoryRespone]>.create { [weak self] single in
            self?.recordAPI.categoryFetch(cateType: type, request: .init(postId: postId, size: size, sortType: sort, userid: userid), completion: { result in
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

    func myRecordFetch(userid: Int) -> Single<[MyRecordRespone]> {
        Single<[MyRecordRespone]>.create { [weak self] single in
            self?.recordAPI.myRecordFetch(userid: userid, completion: { result in
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

    func save(cate: String, content: String, isPublic: Bool, musicId: String, title: String, userid: Int, recordImageUrl: String) -> Single<SaveRespone> {
        Single<SaveRespone>.create { [weak self] single in
            self?.recordAPI.saveFetch(request: .init(category: cate, isPublic: isPublic, musicID: musicId, recordContents: content, recordTitle: title, recordImageURL: recordImageUrl, userID: userid), completion: { result in
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

    func recordIspublic(postId: Int) -> Single<StateRespone> {
        Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.recordIspublic(postId: postId, completion: { result in
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

    func recordDelete(postId: Int) -> Single<StateRespone> {
        Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.recordDelete(postId: postId, completion: { result in
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

    func recordUpdate(postId: Int, request: UpdateRequest) -> Single<StateRespone> {
        Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.recordUpdate(postId: postId, request: request, completion: { result in
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

    func oneMusicRecordFetch(musicId: String, request: OneMusicRecordRequest) -> Single<[OneMusicRecordRespone]> {
        Single<[OneMusicRecordRespone]>.create { [weak self] single in
            self?.recordAPI.oneMusicRecordFetch(musicId: musicId, request: request, completion: { result in
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

    func saveScrap(postId: Int, userId: Int) -> Single<StateRespone> {
        Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.saveScrap(postId: postId, userId: userId, completion: { result in
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

    func deleteScrap(postId: Int, userId: Int) -> Single<StateRespone> {
        Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.deleteScrap(postId: postId, userId: userId, completion: { result in
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

    func saveLike(postId: Int, userId: Int) -> Single<StateRespone> {
        Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.saveLike(postId: postId, userId: userId, completion: { result in
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

    func deleteLike(postId: Int, userId: Int) -> Single<StateRespone> {
        Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.deleteLike(postId: postId, userId: userId, completion: { result in
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

    func MyDjAllRecord(userId: Int, myDjRequest: MyDjRequest) -> Single<[MyDjResponse]> {
        Single<[MyDjResponse]>.create { [weak self] single in
            self?.recordAPI.MyDjAllRecord(userId: userId, myDjRequest: myDjRequest, completion: { result in
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
//    func MyDjAllRecord(userId:Int,MyDjRequest:MyDjRequest) -> Single<[MyDjResponse]>
//    func saveFollow(fromId:Int,toId:Int) -> Single<StateRespone>
//    func deleteFollow(fromId:Int,toId:Int) -> Single<StateRespone>
//    func myDjProfile(fromId:Int,toId:Int) -> Single<MyDjProfileResponse>
//    func myDjList(userId:Int) -> Single<[MyDjListResponse]>

    func saveFollow(fromId: Int, toId: Int) -> Single<StateRespone> {
        Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.saveFollow(fromId: fromId, toId: toId, completion: { result in
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

    func deleteFollow(fromId: Int, toId: Int) -> Single<StateRespone> {
        Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.deleteFollow(fromId: fromId, toId: toId, completion: { result in
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

    func myDjProfile(fromId: Int, toId: Int) -> Single<MyDjProfileResponse> {
        Single<MyDjProfileResponse>.create { [weak self] single in
            self?.recordAPI.myDjProfile(fromId: fromId, toId: toId, completion: { result in
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

    func myDjList(userId: Int) -> Single<[MyDjListResponse]> {
        Single<[MyDjListResponse]>.create { [weak self] single in
            self?.recordAPI.myDjList(userId: userId, completion: { result in
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

    func userRecords(fromId: Int, toId: Int) -> Single<[MyDjResponse]> {
        Single<[MyDjResponse]>.create { [weak self] single in
            self?.recordAPI.userRecords(fromId: fromId, toId: toId, completion: { result in
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

    func reportRecord(postId: Int) -> Single<StateRespone> {
        Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.reportRecord(postId: postId, completion: { result in
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

    func userReport(userId: Int) -> Single<StateRespone> {
        Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.userReport(userId: userId, completion: { result in
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

    func awsDeleteImage(request: AwsDeleteImageRequest) -> Single<StateRespone> {
        Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.awsDeleteImage(request: request, completion: { result in
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

    func blockObjcet(type: String, request: BlockRequest) -> Single<StateRespone> {
        Single<StateRespone>.create { [weak self] single in
            self?.recordAPI.blockObjcet(type: type, request: request, completion: { result in
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
