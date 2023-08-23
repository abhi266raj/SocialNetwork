//
//  FeedViewTest.swift
//  ViewTests
//
//  Created by Abhiraj on 05/08/23.
//

import XCTest
@testable import View
import ViewModel
import SwiftUI
import SnapshotTesting
import Observation

@MainActor
final class FeedViewTest: XCTestCase {
    var viewModel: FeedListViewModel!
    var feedView: FeedView!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    var tracker: AnyObject?

    func testFeedView() async throws {
        viewModel = FeedListViewModel(networkService: MockNetworkService().feedAPI())
       
        let expecation = XCTestExpectation()
        feedView = FeedView(viewModel: viewModel)
        let testView = feedView.frame(width: 300, height: 500)
        
            let item = withObservationTracking {
                viewModel.postList
            } onChange: {
                expecation.fulfill()
            }
        
        tracker = item as AnyObject
        viewModel.fetchData()
        await fulfillment(of: [expecation], timeout: 2)
        assertSnapshot(matching: testView, as: .image)
    }

    
}

