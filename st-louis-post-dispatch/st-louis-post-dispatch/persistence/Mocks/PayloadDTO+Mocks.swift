//
//  PayloadDTO+Mocks.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 18/08/24.
//

import Foundation
import CoreData

extension PayloadDTO {
    static func getMock(withContext context: NSManagedObjectContext) throws -> PayloadDTO {
        let message = try PayloadMessage.getMockedPayload()
        let payload = try message.getModel()
        return payload.managedObject(context: context)
    }
}
