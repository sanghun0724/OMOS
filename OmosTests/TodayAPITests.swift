//
//  TodayAPITests.swift
//  OmosTests
//
//  Created by sangheon on 2022/06/02.
//

import XCTest
@testable import Omos

class TodayAPITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // given
        let session = SessionStub()
        let service = TodayAPI(session: session)
        
        // when
        service.popuralRecord(completion: {_ in })
        
        // then
        let expect = "http://ec2-3-39-121-23.ap-northeast-2.compute.amazonaws.com:8080/api/today/famous-records-of-today"
        let actual = try? session.result?.convertible.urlRequest?.url!.asURL().absoluteString
        XCTAssertEqual(expect, actual)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
