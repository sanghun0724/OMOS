//
//  RecordAPI.swift
//  Omos
//
//  Created by sangheon on 2022/03/02.
//

import Foundation
import Alamofire

class RecordAPI {
    
    func getInterceptor() -> AuthenticationInterceptor<MyAuthenticator> {
        //  AuthenticationInterceptor 적용
        let authenticator = MyAuthenticator()
        let credential = MyAuthenticationCredential(accessToken:UserDefaults.standard.string(forKey: "access") ?? "", refreshToken: UserDefaults.standard.string(forKey: "refresh") ?? "", userID: UserDefaults.standard.integer(forKey: "user"))
        let myAuthencitationInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                                    credential: credential)
        return myAuthencitationInterceptor
    }
    
    
    func select(completion:@escaping(Result<SelectResponse,Error>) -> Void) {
        
        AF.request(RecordTarget.select,interceptor: getInterceptor()).responseDecodable { (response:AFDataResponse<SelectResponse>) in
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
        
        AF.request(RecordTarget.category(cate: cateType, request: request),interceptor: getInterceptor()).responseDecodable { (response:AFDataResponse<[CategoryRespone]>) in
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
        
        AF.request(RecordTarget.myRecord(userid: userid),interceptor: getInterceptor()).responseDecodable { (response:AFDataResponse<[MyRecordRespone]>) in
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
        AF.request(RecordTarget.save(request),interceptor: getInterceptor()).responseDecodable { (response:AFDataResponse<SaveRespone>) in
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
    
    
}
