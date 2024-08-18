//
//  WhenFetchingPayload.swift
//  st-louis-post-dispatchTests
//
//  Created by Fernando Campo Garcia on 18/08/24.
//

import XCTest
@testable import st_louis_post_dispatch

final class WhenFetchingPayload: XCTestCase {

    var httpClient: HttpClient!
    var persistenceManager: PersistenceManager!
    var payloadRepository: PayloadRepository!
    
    override func setUpWithError() throws {
        persistenceManager = PersistenceManager(inMemory: true)
        httpClient = MockHttpClient()
        payloadRepository = PayloadRepository(
            context: persistenceManager.container.viewContext,
            httpClient: httpClient
        )
    }
    
    override func tearDownWithError() throws {
        httpClient = nil
        persistenceManager = nil
        payloadRepository = nil
    }

    func testFetchPayloadThatIsNotInDatabase() async throws {
        let context = persistenceManager.container.viewContext
        let payloadId = "66be196bad19ca34f896843d"
        do {
            try await payloadRepository.getPayload(withId: payloadId)
            
            guard let payload = try PayloadDTO.withId(payloadId, context: context) else {
                XCTFail("Object not in the database")
                return
            }
            print(payload)
            XCTAssertEqual(payload.payloadId, payloadId)
        } catch {
            XCTFail("An error occured while fetching API: \(error.localizedDescription)")
        }
    }
}
