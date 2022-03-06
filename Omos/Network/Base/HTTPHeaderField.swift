//
//  HTTPHeaderField.swift
//  Omos
//
//  Created by sangheon on 2022/02/17.
//

import Foundation
import Alamofire

enum HTTPHeaderField:String {
    case authentication = "Autorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
}

enum ContentType:String {
    case json = "Application/json"
}


