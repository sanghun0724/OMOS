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
    
}
