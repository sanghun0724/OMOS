//
//  TodayAPITests.swift
//  OmosTests
//
//  Created by sangheon on 2022/06/02.
//

import XCTest
@testable import Omos
@testable import Alamofire

class TodayAPITests: XCTestCase {
    private var sut: TodayAPI!
    private var session: SessionStub!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        session = SessionStub()
        sut = TodayAPI(session: session)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testPopuralRecord_callsTodayAPIWithParameter() throws {
        // given
        let expectedURL = "http://ec2-3-39-121-23.ap-northeast-2.compute.amazonaws.com:8080/api/today/famous-records-of-today"
        let expectedMethod = HTTPMethod.get

        // when
        sut.popuralRecord(completion: {_ in })
        
        // then
        let actualURL = try? session.result?.convertible.urlRequest?.url!.asURL().absoluteString
        XCTAssertEqual(expectedURL, actualURL)
        
        let actualMethod = session.result?.convertible.urlRequest?.method
        XCTAssertEqual(expectedMethod, actualMethod)
        
        let params = session.result?.convertible.urlRequest?.httpBody
        XCTAssertNil(params)
        
        let actualAccessToken = (session.result?.interceptor as? AuthenticationInterceptor<MyAuthenticator>)?.credential?.accessToken
        let actualRefreshToken = (session.result?.interceptor as? AuthenticationInterceptor<MyAuthenticator>)?.credential?.refreshToken
        XCTAssertNotNil(actualRefreshToken)
        XCTAssertNotNil(actualAccessToken)
    }
    
    

}
