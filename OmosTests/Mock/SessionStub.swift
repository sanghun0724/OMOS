//
//  MockTodayAPI.swift
//  OmosTests
//
//  Created by sangheon on 2022/06/02.
//

@testable import Alamofire
@testable import Omos

class SessionStub: SessionProtocol {
    var result:(convertible:URLRequestConvertible, interceptor: RequestInterceptor?)?
    @discardableResult
    func request(_ convertible: URLRequestConvertible, interceptor: RequestInterceptor?) -> DataRequest {
        self.result = (convertible, interceptor)
        return DataRequest(convertible: convertible, underlyingQueue: .global(), serializationQueue: .global(), eventMonitor: nil, interceptor: interceptor, delegate: DummyClass())
    }
}

class DummyClass: RequestDelegate {
    var sessionConfiguration: URLSessionConfiguration = .default
    
    var startImmediately: Bool = false
    
    func cleanup(after request: Request) {}
    
    func retryResult(for request: Request, dueTo error: AFError, completion: @escaping (RetryResult) -> Void) {}
    
    func retryRequest(_ request: Request, withDelay timeDelay: TimeInterval?) {}
}
