//
//  HttpClientTests.swift
//  st-louis-post-dispatchTests
//
//  Created by Fernando Campo Garcia on 16/08/24.
//

import XCTest
@testable import st_louis_post_dispatch

final class HttpClientTests: XCTestCase {

    var httpClient: HttpClient!
    var apiService: ApiService!
    
    override func setUpWithError() throws {
        httpClient = MockHttpClient()
        apiService = ApiService(client: httpClient)
    }
    
    override func tearDownWithError() throws {
        httpClient = nil
        apiService = nil
    }

    func testPayloadRequestSuccess() async throws {
        let requestURL = ApiHelper.getPayloadUrl()
        
        let response = try await httpClient.performRequest(url: requestURL)
        XCTAssertNotNil(response.data)
        XCTAssertEqual(response.httpResponse.statusCode, 200)
    }

    func testGetPayloadSuccess() async throws {
        let id = "66be196bad19ca34f896843d"
        let payload = try await apiService.getPayload()
        XCTAssertEqual(payload.id, id)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
