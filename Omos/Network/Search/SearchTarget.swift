//
//  SearchTarget.swift
//  Omos
//
//  Created by sangheon on 2022/03/06.
//

import Foundation
import Alamofire

enum SearchTarget {
    
}

extension SearchTarget:TargetType {
    var baseURL: String {
        return "http://ec2-3-37-146-80.ap-northeast-2.compute.amazonaws.com:8080/api/search"
    }
    
    var method: HTTPMethod {
        switch self {
        
        }
    }
    
    var path: String {
        switch self {
      
        }
    }
    
    var parameters: RequestParams? {
        switch self {
      
        }
    }
    
    
}
