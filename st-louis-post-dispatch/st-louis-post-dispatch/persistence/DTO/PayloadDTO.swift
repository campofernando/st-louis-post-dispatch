//
//  PayloadDTO.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 17/08/24.
//

import Foundation
import CoreData

extension PayloadDTO {
    static func withId(_ id: String, context: NSManagedObjectContext) throws -> PayloadDTO? {
        let request = NSFetchRequest<PayloadDTO>(entityName: "PayloadDTO")
        request.predicate = NSPredicate(format: "id_ = %@", id)
        return try context.fetch(request).first
    }
    
    static func currentPayload(context: NSManagedObjectContext) throws -> PayloadDTO? {
        let request = NSFetchRequest<PayloadDTO>(entityName: "PayloadDTO")
        return try context.fetch(request).first
    }
    
    var payloadId: String {
        get {
            id_ ?? UUID().uuidString
        }
        set {
            id_ = newValue
        }
    }
    
    var record: RecordDTO {
        get {
            record_!
        }
        set {
            record_ = newValue
        }
    }
}
