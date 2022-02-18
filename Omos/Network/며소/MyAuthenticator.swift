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
        
        //refresh 토큰 넣어서 post해주면 됨 그리고 오는 데이터 -ㅡ access token 
        
        //        NetworkManager.shared.oauth.doRefreshToken { (jsonDict, error) in
        //                   if let jsonDict = jsonDict {
        //                       let json = JSON(jsonDict)
        //                       let accessToken = json["access_token"].stringValue
        //                       let refreshToken = json["refresh_token"].stringValue
        //                       let expiration = json["expires_in"].doubleValue
        //                       let newCredential = OAuthCredential(accessToken: accessToken, refreshToken: refreshToken, expiration: Date(timeIntervalSinceNow: expiration))
        //                       completion(.success(newCredential))
        //                   }
        //               }
        
        /* TODO: 여기서 리프레쉬 받아오면 되유
        RefreshTokenAPI.refreshToken { result in
            switch result {
            case .success(let accessToken):
                KeychainServiceImpl.shared.accessToken = accessToken
                completion(.retry)
            case .failure(let error):
                completion(.doNotRetryWithError(error))
            }
        }
        */

    }
    
    
    
}
