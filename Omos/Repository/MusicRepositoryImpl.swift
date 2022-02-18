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
        let username = "username"
        let password = "password"
        let loginString = "\(username):\(password)"

        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            fatalError()
        }
        let base64LoginString = loginData.base64EncodedString()
        var request = URLRequest(url: URL(string: "")!)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

        RxAlamofire.requestJSON(request).subscribe(onNext: { (respone,any) in
            do {
                let data = try JSONSerialization.data(withJSONObject: any)
                print(data)
            } catch {
                print(error.localizedDescription)
            }
        }).disposed(by: disposeBag)
        return Single.create { single in
            return Disposables.create()
        }
    }
    
    func localSignUp(_ email: String, _ password: String, _ nickname: String) -> Single<SignUpRespone> {
        
        return Single<SignUpRespone>.create { single in
            LoginAPI.signUp(request: .init(email: email, nickname: nickname, password: password)) { result in
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
