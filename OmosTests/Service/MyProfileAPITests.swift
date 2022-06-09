//
//  MyProfileTests.swift
//  OmosTests
//
//  Created by sangheon on 2022/06/02.
//

@testable import Alamofire
import XCTest
@testable import Omos

class MyProfileAPITests: XCTestCase {
    private var sut: MyProfileAPI!
    private var session: SessionStub!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        session = SessionStub()
        sut = MyProfileAPI(session: session)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testmMyProfile_callsMyProfileAPIWithParameter() throws {
        // given
        let expectedURL = "http://ec2-3-39-121-23.ap-northeast-2.compute.amazonaws.com:8080/api/user/\(Account.currentUser)"
        let expectedMethod = HTTPMethod.get

        // when
        sut.myProfile(userId: Account.currentUser, completion: { _ in })
        
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
    
    func testmUpdatePassword_callsMyProfileAPIWithParameter() throws {
        // given
        let expectedURL = "http://ec2-3-39-121-23.ap-northeast-2.compute.amazonaws.com:8080/api/auth/update/password"
        let expectedMethod = HTTPMethod.put

        // when
        sut.updatePassword(request: .init(password: "password", userId: Account.currentUser), completion: { _ in })
        
        // then
        let actualURL = try? session.result?.convertible.urlRequest?.url!.asURL().absoluteString
        XCTAssertEqual(expectedURL, actualURL)
        
        let actualMethod = session.result?.convertible.urlRequest?.method
        XCTAssertEqual(expectedMethod, actualMethod)
        
        let params = session.result?.convertible.urlRequest?.httpBody
        XCTAssertNotNil(params)
        
        let actualAccessToken = (session.result?.interceptor as? AuthenticationInterceptor<MyAuthenticator>)?.credential?.accessToken
        let actualRefreshToken = (session.result?.interceptor as? AuthenticationInterceptor<MyAuthenticator>)?.credential?.refreshToken
        XCTAssertNotNil(actualRefreshToken)
        XCTAssertNotNil(actualAccessToken)
    }

}
