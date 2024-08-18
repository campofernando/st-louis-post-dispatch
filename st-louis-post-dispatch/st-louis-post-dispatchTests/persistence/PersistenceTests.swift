//
//  PersistenceTests.swift
//  st-louis-post-dispatchTests
//
//  Created by Fernando Campo Garcia on 18/08/24.
//

import XCTest
@testable import st_louis_post_dispatch

final class PersistenceTests: XCTestCase {

    var persistenceManager: PersistenceManager!
    
    override func setUpWithError() throws {
        persistenceManager = PersistenceManager(inMemory: true)
    }
    
    override func tearDownWithError() throws {
        persistenceManager = nil
    }

    func testSaveNewItem() throws {
        let context = persistenceManager.container.viewContext
        let payloadId = "66be196bad19ca34f896843d"
        do {
            let item = try PayloadDTO.getMock(withContext: context)
            item.objectWillChange.send()
            try context.save()
            guard let payload = try PayloadDTO.withId(payloadId, context: context) else {
                XCTFail("Object not in the database")
                return
            }
            XCTAssertEqual(payload.payloadId, payloadId)
        } catch {
            XCTFail("An error occured while fetching API: \(error.localizedDescription)")
        }
    }
}
