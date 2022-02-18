//
//  MyAuthenticator.swift
//  Omos
//
//  Created by sangheon on 2022/02/17.
//

import Alamofire

class MyAuthenticator:Authenticator {
    typealias Credential = MyAuthenticationCredential
    
    func apply(_ credential: Credential, to urlRequest: inout URLRequest) {
        urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
        urlRequest.addValue(credential.refreshToken, forHTTPHeaderField: "refresh-token")
    }
    
    func didRequest(_ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: Error) -> Bool {
        return response.statusCode == 401
    }
    
    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: Credential) -> Bool {
        // bearerToken의 urlRequest에 대해서만 refresh를 시도 (true)
        let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
        return urlRequest.headers["Authorization"] == bearerToken
    }
    
    func refresh(_ credential: Credential, for session: Session, completion: @escaping (Result<MyAuthenticationCredential, Error>) -> Void) {
        let requeust = RefreshRequest(accessToken: "asdsad", refreshToken: "123", userId: 2)
        LoginAPI.doRefresh(request: requeust) { response in
            switch response {
            case .success(let data):
                print("success sisisisi")
                print(data)
                let accessToken = ""
                let refreshToken = ""
                let expiration = Date()
                let newCredential = MyAuthenticationCredential(accessToken: accessToken, refreshToken: refreshToken, expiredAt: expiration)
                completion(.success(newCredential))
            case .failure(let error):
                completion(.failure(error))
                print(error)
            }
        }

    }

}
