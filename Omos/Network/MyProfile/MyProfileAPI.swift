//
//  MyProfileAPI.swift
//  Omos
//
//  Created by sangheon on 2022/03/20.
//

import Foundation
import Alamofire

class MyProfileAPI {
    
    func myProfile(userId:Int,completion:@escaping(Result<myProfileResponse,Error>) -> Void) {
        AF.request(MyProfileTarget.myProfile(userId:userId),interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<myProfileResponse>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func updatePassword(request:PWUpdateRequest,completion:@escaping(Result<StateRespone,Error>) -> Void) {
        AF.request(MyProfileTarget.updatePassword(request),interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<StateRespone>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func updateProfile(request:ProfileUpdateRequest,completion:@escaping(Result<StateRespone,Error>) -> Void) {
        AF.request(MyProfileTarget.updateProfile(request),interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<StateRespone>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func likeRecords(userId:Int,completion:@escaping(Result<[MyRecordRespone],Error>) -> Void) {
            AF.request(RecordTarget.likeRecords(userId: userId),interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<[MyRecordRespone]>) in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                    print(data)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
    }
    
    
    func scrapRecords(userId:Int,completion:@escaping(Result<[MyRecordRespone],Error>) -> Void) {
            AF.request(RecordTarget.scrapRecords(userId: userId),interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<[MyRecordRespone]>) in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                    print(data)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
    }
    
    func myProfileRecords(userId:Int,completion:@escaping(Result<MyProfileRecordResponse,Error>) -> Void) {
        AF.request(RecordTarget.myProfileRecords(userId: userId),interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<MyProfileRecordResponse>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func logOut(userId:Int,completion:@escaping(Result<StateRespone,Error>) -> Void) {
        AF.request(LoginTarget.logOut(userId: userId),interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<StateRespone>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func myDjProfile(fromId:Int,toId:Int,completion:@escaping(Result<MyDjProfileResponse,Error>) -> Void) {
        AF.request(FollowTarget.myDjProfile(fromId: fromId, toId: toId),interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<MyDjProfileResponse>) in
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
    
    
    func signOut(userId:Int,completion:@escaping(Result<StateRespone,Error>) -> Void) {
        AF.request(LoginTarget.signout(userId: userId),interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response:AFDataResponse<StateRespone>) in
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
