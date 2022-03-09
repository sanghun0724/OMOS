//
//  RecordAPI.swift
//  Omos
//
//  Created by sangheon on 2022/03/02.
//

import Foundation
import Alamofire

class RecordAPI {
    
   
    
    
    func select(completion:@escaping(Result<SelectResponse,Error>) -> Void) {
        
        AF.request(RecordTarget.select,interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<SelectResponse>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func categoryFetch(cateType:cateType,request:CateRequest,completion:@escaping(Result<[CategoryRespone],Error>) -> Void) {
        
        AF.request(RecordTarget.category(cate: cateType, request: request),interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<[CategoryRespone]>) in
            switch response.result {
            case .success(let data):
                print(data)
                
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func myRecordFetch(userid:Int,completion:@escaping(Result<[MyRecordRespone],Error>) -> Void) {
        
        AF.request(RecordTarget.myRecord(userid: userid),interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<[MyRecordRespone]>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        
    }
    
    func saveFetch(request:SaveRequest,completion:@escaping(Result<SaveRespone,Error>) -> Void) {
        AF.request(RecordTarget.save(request),interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<SaveRespone>) in
            switch response.result {
            case .success(let data):
                print(data)
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func searchRecordFetch(musicId:String,request:SearchRecordRequest,completion:@escaping(Result<SaveRespone,Error>) -> Void) {
        AF.request(RecordTarget.searchRecord(musicId:musicId,request),interceptor: TokenInterceptor.shared.getInterceptor()).responseString { result in
            print(result)
        }
    }
    
    func recordIspublic(postId:String) {
        AF.request(RecordTarget.recordIspublic(postId: postId),interceptor: TokenInterceptor.shared.getInterceptor()).responseString { result in
            print(result)
        }
    }
    
    func recordDelete(postId:String) {
        AF.request(RecordTarget.recordDelete(postId: postId),interceptor: TokenInterceptor.shared.getInterceptor()).responseString { result in
            print(result)
        }
    }
    
    func recordUpdate(postId:String,request:UpdateRequest) {
        AF.request(RecordTarget.recordUpdate(postId: postId,request),interceptor: TokenInterceptor.shared.getInterceptor()).responseString { result in
            print(result)
        }
    }
    
}
