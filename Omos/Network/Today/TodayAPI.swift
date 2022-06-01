//
//  TodayAPI.swift
//  Omos
//
//  Created by sangheon on 2022/03/15.
//

import Alamofire
import Foundation

class TodayAPI {
    private let session: SessionProtocol

    init(session: SessionProtocol) {
      self.session = session
    }
        
    func popuralRecord(completion:@escaping(Result<[PopuralResponse], Error>) -> Void) {
        session.request(TodayTarget.popuralRecord, interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response: AFDataResponse<[PopuralResponse]>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }

    func lovedRecord(userId: Int, completion:@escaping(Result<LovedResponse, Error>) -> Void) {
        AF.request(TodayTarget.lovedRecord(userId: userId), interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response: AFDataResponse<LovedResponse>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }

    func recommedRecord(completion:@escaping(Result<[RecommendDjResponse], Error>) -> Void) {
        AF.request(TodayTarget.recommendDJRecord, interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response: AFDataResponse<[RecommendDjResponse]>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }

    func todayTrackRecord(completion:@escaping(Result<TodayTrackResponse, Error>) -> Void) {
        AF.request(TodayTarget.todayRecord, interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response: AFDataResponse<TodayTrackResponse>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
