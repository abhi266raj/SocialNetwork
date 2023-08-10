//
//  VideoViewerUITests.swift
//  VideoViewerUITests
//
//  Created by Abhiraj on 05/08/23.
//

import XCTest


extension  XCTest {
    static let timeout: TimeInterval = 5
}
class FeedPage {
    func create(app: XCUIApplication) {
        let feedStaticText = app.staticTexts["Feed"]
        XCTAssert(feedStaticText.waitForExistence(timeout: 5), "First Item should exist")
    }
}

class DetailPage {
    
    func create(app: XCUIApplication) {
        let feedPage = FeedPage()
        feedPage.create(app: app)
        let firstItem = app.descendants(matching: .any).matching(identifier: "item0").element
        XCTAssert(firstItem.waitForExistence(timeout: 5), "First Item should exist")
        firstItem.firstMatch.tap()
    }
}


class ProfilePage {
    
    func create(app: XCUIApplication) {
        let page = DetailPage()
        page.create(app: app)
        let profilePageButton = app.images["Love"]
        XCTAssert(profilePageButton.waitForExistence(timeout: 5), "Like icon should exist")
        profilePageButton.firstMatch.tap()
    }
}
