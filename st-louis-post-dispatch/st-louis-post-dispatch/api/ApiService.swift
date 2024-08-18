//
//  ApiService.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 16/08/24.
//

import Foundation

enum ApiHelper {
    static private let domain = "https://api.jsonbin.io"
    static private let payloadPath = "/v3/qs/66be196bad19ca34f896843d"
    
    static func getPayloadUrl() -> URL? {
        let urlPath = domain + payloadPath
        return URL(string: urlPath)
    }
}

enum PayloadMapper {
    struct InvalidResponseStatus: Error { }
    struct InvalidPayloadMessage: Error { }
    
    static func map(response: HttpClientResponse) throws -> Payload {
        if response.httpResponse.statusCode == 200 {
            let payloadMessage = try JSONDecoder().decode(PayloadMessage.self, from: response.data)
            return try payloadMessage.getModel()
        }
        
        throw InvalidResponseStatus()
    }
}

struct ApiService {
    let client: HttpClient
    
    init(client: HttpClient) {
        self.client = client
    }
    
    func getPayload() async throws -> Payload {
        let response = try await client.performRequest(url: ApiHelper.getPayloadUrl())
        return try PayloadMapper.map(response: response)
    }
}
