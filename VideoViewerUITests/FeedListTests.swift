//
//  VideoViewerUITestsLaunchTests.swift
//  VideoViewerUITests
//
//  Created by Abhiraj on 05/08/23.
//

import XCTest



final class FeedListTests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        let page = FeedPage()
        page.create(app: app)
    }

    func testFirstItemInFeedExists() throws {
        let firstItem = app.descendants(matching: .any).matching(identifier: "item0").element
        XCTAssert(firstItem.waitForExistence(timeout: 5), "First Item should exist")
    }
}
