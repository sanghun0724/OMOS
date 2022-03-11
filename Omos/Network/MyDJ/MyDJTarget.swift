//
//  MyDJTarget.swift
//  Omos
//
//  Created by sangheon on 2022/03/11.
//

import Foundation
import Alamofire

enum MyDJTarget {
//    case saveFollow(fromId:Int,toId:Int)
//    case deleteFollow(fromId:Int,toId:Int)
//    case myDjProfile(fromId:Int,toId:Int)
}

extension MyDJTarget:TargetType {
    var baseURL: String {
        return "http://ec2-3-37-146-80.ap-northeast-2.compute.amazonaws.com:8080/api/"
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
