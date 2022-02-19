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
//        let authenticator = MyAuthenticator()
//        let credential = MyAuthenticationCredential(accessToken:UserDefaults.standard.string(forKey: "access") ?? "", refreshToken: UserDefaults.standard.string(forKey: "refresh") ?? "", userID: 0)
//
//        let myAuthencitationInterceptor = AuthenticationInterceptor(authenticator: authenticator,
//                                                                    credential: credential)
        
        AF.request(LoginTarget.login(request))
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
    
    static func checkEmail(email:String,completion:@escaping(Result<Bool,Error>) -> Void) {
      
        let params:[String:Any] = [
            "email":email
        ]
        
        let url = URL(string: "http://ec2-3-37-146-80.ap-northeast-2.compute.amazonaws.com:8080/api/auth/check-email")!
        AF.request(url, method: .get, parameters: params , encoding:URLEncoding.default, headers: nil).responseString { response in
                        switch response.result {
                        case .success(let data):
                            print(data)
                            data == "true" ? completion(.success(true)) : completion(.success(false))
                        case .failure(let error):
                            print(error.localizedDescription) //같은 닉네임
                            completion(.failure(error))
                        }
        }
        
//        AF.request(LoginTarget.checkEmail(request)).responseString { response in
//            switch response.result {
//            case .success(let data):
//                print(data)
//                completion(.success(data))
//            case .failure(let error):
//                print(error.localizedDescription) //같은 닉네임
//                completion(.failure(error))
//            }
//        }
    }
}
