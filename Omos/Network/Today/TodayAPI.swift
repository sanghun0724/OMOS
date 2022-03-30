//
//  TodayAPI.swift
//  Omos
//
//  Created by sangheon on 2022/03/15.
//

import Foundation
import Alamofire

class TodayAPI {
    
    func popuralRecord(completion:@escaping(Result<[PopuralResponse],Error>) -> Void) {
        AF.request(TodayTarget.popuralRecord,interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<[PopuralResponse]>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func lovedRecord(userId:Int,completion:@escaping(Result<LovedResponse,Error>) -> Void) {
        AF.request(TodayTarget.lovedRecord(userId:userId),interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<LovedResponse>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func recommedRecord(completion:@escaping(Result<[recommendDjResponse],Error>) -> Void) {
        AF.request(TodayTarget.recommendDJRecord,interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<[recommendDjResponse]>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func todayTrackRecord(completion:@escaping(Result<TodayTrackResponse,Error>) -> Void) {
        AF.request(TodayTarget.todayRecord,interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<TodayTrackResponse>) in
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
