//
//  ServiceTests.swift
//  ServiceTests
//
//  Created by Abhiraj on 05/08/23.
//

import XCTest
@testable import Service

class NetworkServiceTests: XCTestCase {

    // Create a mock URLSessionProtocol for testing
    class MockURLSession: URLSessionProtocol {
        var testData: Data?
        var testResponse: URLResponse?
        var testError: Error?

        func data(for request: URLRequest) async throws -> (Data, URLResponse) {
            if let testData = testData, let testResponse = testResponse {
                return (testData, testResponse)
            }
            throw testError!
        }
    }

    func testFetchUsingSuccess() async throws {
        // Create a mock URLSession
        let mockURLSession = MockURLSession()

        // Prepare test data
        let jsonData = """
            {"key": "value"}
        """.data(using: .utf8)!
        let response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        mockURLSession.testData = jsonData
        mockURLSession.testResponse = response

        // Create a NetworkObject for testing
        struct TestNetworkObject: NetworkObject {
            typealias RequestObject = MockRequestBuilder
            typealias ResponseObject = ModelResponseBuilder<TestModel>

            var requestBuilder: RequestObject { MockRequestBuilder() }
            var responseBuilder: ResponseObject { ModelResponseBuilder<TestModel>() }
        }

        // Create a NetworkServiceImp instance with the mock URLSession
        let networkService = NetworkServiceImp(urlSession: mockURLSession)

        // Perform the test
        let result = try await networkService.fetchUsing(TestNetworkObject())

        // Validate the result
        XCTAssertEqual(result.key, "value")
    }

    func testFetchUsingFailure() async {
        // Create a mock URLSession
        let mockURLSession = MockURLSession()

        // Prepare test error
        let testError = NSError(domain: "TestErrorDomain", code: 123, userInfo: nil)
        mockURLSession.testError = testError

        // Create a NetworkObject for testing
        struct TestNetworkObject: NetworkObject {
            typealias RequestObject = MockRequestBuilder
            typealias ResponseObject = ModelResponseBuilder<TestModel>

            var requestBuilder: RequestObject { MockRequestBuilder() }
            var responseBuilder: ResponseObject { ModelResponseBuilder<TestModel>() }
        }

        // Create a NetworkServiceImp instance with the mock URLSession
        let networkService = NetworkServiceImp(urlSession: mockURLSession)

        // Perform the test and expect an error
        do {
            _ = try await networkService.fetchUsing(TestNetworkObject())
            XCTFail("Expected an error.")
        } catch {
            XCTAssertEqual(error as NSError, testError)
        }
    }

    // Define mock classes for testing
    struct MockRequestBuilder: RequestBuilder {
        func createRequest() -> URLRequest {
            return URLRequest(url: URL(string: "https://example.com")!)
        }
    }

    struct TestModel: Decodable {
        let key: String
    }
}
