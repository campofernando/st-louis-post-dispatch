//
//  PayloadMessage+Mocks.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 16/08/24.
//

import Foundation

extension PayloadMessage {
    static func getMockedPayload() throws -> PayloadMessage {
        guard let url = Bundle.main.url(forResource: "payloadMock", withExtension: "json") else {
            throw NSError(domain: "payloadMock.json file not found", code: 1121)
        }
        let jsonData = try Data(contentsOf: url)
        let item = try JSONDecoder().decode(PayloadMessage.self, from: jsonData)
        return item
    }
}

extension ApiHelper {
    static func getMockedHttpResponse(url: URL?) throws -> HttpClientResponse {
        guard let payloadUrl = Bundle.main.url(forResource: "payloadMock", withExtension: "json") else {
            throw NSError(domain: "payloadMock.json file not found", code: 1121)
        }
        let data = try Data(contentsOf: payloadUrl)
        
        guard let url else {
            throw URLSession.InvalidURLRequestError()
        }
        
        guard let response = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil) else {
            throw URLSession.InvalidHttpResponseError()
        }
        
        return (data, response)
    }
}
