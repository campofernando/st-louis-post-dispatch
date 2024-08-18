//
//  PayloadRepository.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 17/08/24.
//

import Foundation
import CoreData

struct PayloadRepository {
    private let context: NSManagedObjectContext
    private let apiService: ApiService
    
    init(context: NSManagedObjectContext, httpClient: HttpClient) {
        self.context = context
        self.apiService = ApiService(client: httpClient)
    }
    
    @discardableResult
    func getPayload(withId id: String) async throws -> Payload {
        if let payload = try PayloadDTO.withId(id, context: context) {
            return Payload(managedObject: payload)
        }
        let fetchedPayload = try await apiService.getPayload()
        let payloadDTO = fetchedPayload.managedObject(context: context)
        payloadDTO.objectWillChange.send()
        try context.save()
        return fetchedPayload
    }
}
