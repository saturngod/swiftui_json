//
//  ExtensionTest.swift
//  NewsArticlesTests
//
//  Created by Htain Lin Shwe on 30/11/2023.
//

import XCTest

final class ExtensionTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDateAgo() throws {
        let calendar = Calendar.current
        let now = Date()
        
        // When
        let oneYearAgo = calendar.date(byAdding: .year, value: -1, to: now)!
        let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: now)!
        let oneDayAgo = calendar.date(byAdding: .day, value: -1, to: now)!
        let oneHourAgo = calendar.date(byAdding: .hour, value: -1, to: now)!
        let oneMinuteAgo = calendar.date(byAdding: .minute, value: -1, to: now)!
        
        // Then
        XCTAssertEqual(oneYearAgo.ago(), "1y ago")
        XCTAssertEqual(oneMonthAgo.ago(), "1m ago")
        XCTAssertEqual(oneDayAgo.ago(), "1d ago")
        XCTAssertEqual(oneHourAgo.ago(), "1h ago")
        XCTAssertEqual(oneMinuteAgo.ago(), "1m ago")
        XCTAssertEqual(now.ago(), "Now")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
