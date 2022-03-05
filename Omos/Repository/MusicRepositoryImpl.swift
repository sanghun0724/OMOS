//
//  MusicRepositoryImpl.swift
//  Omos
//
//  Created by sangheon on 2022/02/09.
//

import Foundation
import RxSwift
import RxAlamofire

class MusicRepositoryImpl:MusicRepository {
    
    let disposeBag = DisposeBag()
    let apiKey:String = ""
    let loginAPI:LoginAPI
    
    required init(loginAPI:LoginAPI) {
        self.loginAPI = loginAPI
    }
    
    func fetchMusicList(keyword: String) -> Single<StockResult> {
        /// 1.parse query String
        let queryResult = parseqQueryString(text: keyword)
        var query = ""
        switch queryResult {
        case .success(let value):
        query = value
        case .failure(let error):
            return .error(error)
        }
        /// 2. parse URL String
        let urlResult = parseURL(urlString:  "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(query)&apikey=\(apiKey)")
            switch urlResult {
            case .failure(let error):
                return .error(error)
            case .success(let url):
                return Single<StockResult>.create { [weak self] single in
                    guard let self = self else { return Disposables.create() }
                   var request = URLRequest(url: url)
                    
                    request.method = .get
                    request.headers = [
                        "Accept":"application/json"
                    ]
                
                    RxAlamofire.requestJSON(request).subscribe(onNext: { (respone,any) in
                        do {
                            let data = try JSONSerialization.data(withJSONObject: any)
                            let music = try JSONDecoder().decode(StockResult.self, from: data)
                            single(.success(music))
                            print(music)
                        } catch let error {
                            single(.failure(error))
                            print(error.localizedDescription)
                        }
                    }).disposed(by: self.disposeBag)
                    
                    return Disposables.create()
                }
                
            }
        }
    
    private func parseURL(urlString:String) -> Result<URL,Error> {
        if let url = URL(string: urlString) {
            return .success(url)
        } else  {
            let error:MyError = .badUrl
            return .failure(error)
        }
    }
    
    private func parseqQueryString(text:String) -> Result<String,Error> {
        if let query = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            return .success(query)
        } else {
            let error:MyError = .encoding
            return .failure(error)
        }
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
