//
//  RefreshTokenAPI.swift
//  Omos
//
//  Created by sangheon on 2022/02/17.
//

import Alamofire
import Foundation

class RefreshTokenAPI {
    static let shared = RefreshTokenAPI()

    private init() {}

    func refreshToken(completion: @escaping (Result<String, Error>) -> Void) {
//        let userID = UserDefaults.standard.integer(forKey: "id")
//        let accessToken = UserDefaults.standard.string(forKey: "accessKey")
        let url = URL(string: "https://ptsv2.com/t/4e47p-1645176452/post")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10

        let params: [String: Any] = [
              "accessToken": "test",
              "refreshToken": "test",
              "userId": 1
        ]

        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http body error")
        }

        AF.request(request).responseString { response in
            switch response.result {
            case .success(let data):
                print("success")
                print("data is here \(data)")

            case .failure(let error):
                print(error)
            }
        }
    }
}

struct JWTModel: Codable {
    let accessToken: String
    let refreshToken: String
    let userId: Int
}
