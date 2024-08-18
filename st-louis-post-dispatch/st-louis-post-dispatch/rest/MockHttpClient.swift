//
//  MockHttpClient.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 16/08/24.
//

import Foundation

struct MockHttpClient: HttpClient {func performRequest(url: URL?) async throws -> HttpClientResponse {
        return try ApiHelper.getMockedHttpResponse(url: url)
    }
    
    func downloadFile(fromUrl url: URL?) async throws -> URL {
        return try FileHelper.getMockLocalUrl()
    }
}
