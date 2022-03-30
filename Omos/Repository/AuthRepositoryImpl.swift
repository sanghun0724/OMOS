//
//  MusicRepositoryImpl.swift
//  Omos
//
//  Created by sangheon on 2022/02/09.
//

import Foundation
import RxSwift
import RxAlamofire

class AuthRepositoryImpl:AuthRepository {
    
    let disposeBag = DisposeBag()
    let loginAPI:LoginAPI
    
    required init(loginAPI:LoginAPI) {
        self.loginAPI = loginAPI
    }

    //MARK: Login API Caller
    func signIn(_ email: String, _ password: String) -> Single<LoginResponse> {
        return Single<LoginResponse>.create { [weak self] single in
            self?.loginAPI.login(request: .init(email: email, password: password)) { result in
                switch result {
                case .success(let data):
                    print("sign Up success \(data)")
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
    
    func localSignUp(_ email: String, _ password: String, _ nickname: String) -> Single<SignUpRespone> {
        
        return Single<SignUpRespone>.create { [weak self] single in
            self?.loginAPI.signUp(request: .init(email: email, nickname: nickname, password: password)) { result in
                switch result {
                case .success(let data):
                    print("sign Up success \(data)")
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
    
    func checkEmail(email:String) -> Single<CheckEmailRespone> {
        return Single<CheckEmailRespone>.create { [weak self] single in
            self?.loginAPI.checkEmail(email: email, completion: { result in
                switch result {
                case .success(let data):
                    print("sign Up success \(data)")
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            })
            
            return Disposables.create()
        }
    }
    
    func snsLogin(email:String,type:SNSType) -> Single<SNSLoginResponse> {
         return Single<SNSLoginResponse>.create { single in
             LoginAPI.SNSLogin(request:.init(email: email, type: type) ) { result in
                switch result {
                case .success(let data):
                    print("sign Up success \(data)")
                    single(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
    
    func snsSignUp(email:String,nickName:String,type:SNSType) -> Single<SNSSignUpResponse> {
        return Single<SNSSignUpResponse>.create { [weak self] single in
            self?.loginAPI.SNSSignUp(request: .init(email: email, nickname: nickName, type: type)) { result in
               switch result {
               case .success(let data):
                   print("sign Up success \(data)")
                   single(.success(data))
               case .failure(let error):
                   print(error.localizedDescription)
                   single(.failure(error))
               }
           }
           
           return Disposables.create()
       }
    }
    
}
