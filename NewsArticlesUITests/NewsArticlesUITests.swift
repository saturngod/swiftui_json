//
//  NewsArticlesUITests.swift
//  NewsArticlesUITests
//
//  Created by Htain Lin Shwe on 30/11/2023.
//

import XCTest

final class NewsArticlesUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
      
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }

    func testHomeView() throws {
       
      
        XCTAssertTrue(app.navigationBars["News Feed"].exists)
        
        let feed = app.collectionViews["FEED"]
        XCTAssert(feed.waitForExistence(timeout: 10))
        let firstRow = feed.staticTexts["FEED_ITEM"].firstMatch
        XCTAssert(firstRow.waitForExistence(timeout: 10))
        
        XCTAssertEqual("Tesla: The Top Is Here", firstRow.label)
                
    }
    
    func testDetailView() throws {
        let feed = app.collectionViews["FEED"]
        let firstRow = feed.cells.firstMatch
        firstRow.tap()
        
        let segmentControl = app.segmentedControls["PICKER_VIEW"]
        XCTAssert(segmentControl.waitForExistence(timeout: 0.5))
        
        let webButton = segmentControl.buttons["Web"]
        XCTAssert(webButton.waitForExistence(timeout: 0.5))
        
        
        webButton.tap()
        
        let webview = app.webViews.firstMatch
        XCTAssert(webview.waitForExistence(timeout: 3))
        
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
