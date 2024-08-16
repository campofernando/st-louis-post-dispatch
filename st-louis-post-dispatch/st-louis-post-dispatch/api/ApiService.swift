//
//  ApiService.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 16/08/24.
//

import Foundation

struct ApiService {
    let client: HttpClient
    
    init(client: HttpClient) {
        self.client = client
    }
    
    func getPayload() async throws -> PayloadMessage {
        let response = try await client.performRequest(url: ApiHelper.getPayloadUrl())
        return try PayloadMapper.map(response: response)
    }
}
