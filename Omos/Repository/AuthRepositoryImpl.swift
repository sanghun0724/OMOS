//
//  MusicRepositoryImpl.swift
//  Omos
//
//  Created by sangheon on 2022/02/09.
//

import Foundation
import RxAlamofire
import RxSwift

class AuthRepositoryImpl: AuthRepository {
    let disposeBag = DisposeBag()
    let loginAPI: LoginAPI

    required init(loginAPI: LoginAPI) {
        self.loginAPI = loginAPI
    }

    // MARK: Login API Caller
    func signIn(_ email: String, _ password: String) -> Single<LoginResponse> {
        Single<LoginResponse>.create { [weak self] single in
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
        Single<SignUpRespone>.create { [weak self] single in
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

    func checkEmail(email: String) -> Single<CheckEmailRespone> {
        Single<CheckEmailRespone>.create { [weak self] single in
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

    func snsLogin(email: String, type: SNSType) -> Single<SNSLoginResponse> {
         Single<SNSLoginResponse>.create { single in
             LoginAPI.SNSLogin(request: .init(email: email, type: type) ) { result in
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

    func snsSignUp(email: String, nickName: String, type: SNSType) -> Single<SNSSignUpResponse> {
        Single<SNSSignUpResponse>.create { [weak self] single in
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

    func emailVerify(email: String) -> Single<EmailCheckResponse> {
        Single<EmailCheckResponse>.create { [weak self] single in
            self?.loginAPI.emailCheck(request: .init(email: email)) { result in
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
