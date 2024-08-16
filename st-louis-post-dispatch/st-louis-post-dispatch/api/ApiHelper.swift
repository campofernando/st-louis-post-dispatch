//
//  ApiHelper.swift
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

struct PayloadMapper {
    struct InvalidResponseStatus: Error { }
    
    static func map(response: HttpClientResponse) throws -> PayloadMessage {
        if response.httpResponse.statusCode == 200 {
            let payload = try JSONDecoder().decode(PayloadMessage.self, from: response.data)
            return payload
        }
        
        throw(InvalidResponseStatus())
    }
}
