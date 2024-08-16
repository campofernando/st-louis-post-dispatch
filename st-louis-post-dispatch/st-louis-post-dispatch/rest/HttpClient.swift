//
//  HttpClient.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 16/08/24.
//

import Foundation

typealias HttpClientResponse = (data: Data, httpResponse: HTTPURLResponse)

enum NetworkError: Error {
    case notFound
    case badRequest
    case unknown
}

protocol HttpClient {
    func performRequest(url: URL?) async throws -> HttpClientResponse
}

extension URLSession: HttpClient {
    struct InvalidURLRequestError: Error { }
    struct InvalidHttpResponseError: Error { }
    
    func performRequest(url: URL?) async throws -> HttpClientResponse {
        guard let url else {
            throw(InvalidURLRequestError())
        }
        
        let request = URLRequest(url: url)
        let (data, response) = try await data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw InvalidHttpResponseError()
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return (data, httpResponse)
        case 400...499:
            throw NetworkError.notFound
        case 500...599:
            throw NetworkError.badRequest
        default:
            throw NetworkError.unknown
        }
    }
}
