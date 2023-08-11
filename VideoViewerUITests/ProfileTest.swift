//
//  ProfileTest.swift
//  VideoViewerUITests
//
//  Created by Abhiraj on 10/08/23.
//

import XCTest

final class ProfileTest: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        let page = ProfilePage()
        page.create(app: app)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLikeButton() throws {
        let firstItem = app.descendants(matching: .any).matching(identifier: "item0").element
        XCTAssert(firstItem.waitForExistence(timeout: XCTest.timeout), "User should have created one post")
                
        
    }
}
