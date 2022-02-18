//
//  LoginAPI.swift
//  Omos
//
//  Created by sangheon on 2022/02/17.
//

import Foundation
import Alamofire

struct LoginAPI {
    
    static func login(request:LoginRequest,completion:@escaping(Result<LoginResponse,MyError>) -> Void) {
        // AuthenticationInterceptor 적용
        let authenticator = MyAuthenticator()
        let credential = MyAuthenticationCredential(accessToken: "",
                                                    refreshToken: "",
                                                    expiredAt: Date(timeIntervalSinceNow: 60 * 1200))
        let myAuthencitationInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                                    credential: credential)
        
        print(LoginTarget.login(request))
        AF.request(LoginTarget.login(request),interceptor: myAuthencitationInterceptor)
            .responseDecodable { (response: AFDataResponse<LoginResponse>) in
                switch response.result {
                case .success(let data):
                    print(data)
                    completion(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(MyError.badResponse))
                }
            }
    }
    
    static func doRefresh(request:RefreshRequest,completion:@escaping(Result<RefreshRespone,Error>) -> Void) {

        print(LoginTarget.doRefresh(request))
        AF.request(LoginTarget.doRefresh(request)).responseDecodable { (response:AFDataResponse<RefreshRespone>) in
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
    
    static func signUp(request:SignUpRequest,completion:@escaping(Result<SignUpRespone,Error>) -> Void) {
        
        AF.request(LoginTarget.signUp(request)).responseDecodable { (response:AFDataResponse<SignUpRespone>) in
            switch response.result {
            case .success(let data):
                print(data)
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription) //같은 닉네임
                completion(.failure(error))
            }
        }
    }
}
