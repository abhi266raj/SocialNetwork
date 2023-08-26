//
//  ProfileDetailTest.swift
//  VideoViewerUITests
//
//  Created by Abhiraj on 10/08/23.
//

import XCTest

final class PostDetailTest: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["-openURL", "www.google.com/post/1"]
        app.launch()
    }

    func testLikeButton() throws {
        let likeButton = app.buttons["Love"]
        XCTAssert(likeButton.waitForExistence(timeout: XCTest.timeout), "Like Button should exist")
                                        
        
    }
}
