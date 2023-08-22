//
//  FirstViewTest.swift
//  ViewTests
//
//  Created by Abhiraj on 22/08/23.
//

import XCTest
@testable import View
@testable import ViewModel
import SwiftUI
import SnapshotTesting

final class FirstViewTests: XCTestCase {
    
    var testView: AnyView!
    private var viewModel: MockApiCallLodable!
    class MockApiCallLodable: ApiCallLodable {
        var firstApiViewModel = APIResultViewModel()
    }

    override func setUpWithError() throws {
        viewModel = MockApiCallLodable()
        let view = FirstApiView(viewModel: viewModel){
            Text("2")
        }
        testView = AnyView(view.frame(width: 200, height: 200))
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testLoadingState() throws {
        assertSnapshot(matching: testView, as: .image)
    }
    
    @MainActor func testLoadedState() throws {
        viewModel.firstApiViewModel.state = .success
        assertSnapshot(matching: testView, as: .image)
        
    }
    
    @MainActor func testFailureState() throws {
        viewModel.firstApiViewModel.state = .error("test failure")
        assertSnapshot(matching: testView, as: .image)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}


