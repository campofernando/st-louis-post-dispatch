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
    func downloadFile(fromUrl url: URL?) async throws -> URL
}

extension URLSession: HttpClient {
    struct InvalidURLRequestError: Error { }
    struct InvalidHttpResponseError: Error { }
    struct URLSessionDownloadError: Error { }
    struct InvalidFileLocationError: Error { }
    
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
    
    func downloadFile(fromUrl url: URL?) async throws -> URL {
        guard let url else {
            throw(InvalidURLRequestError())
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            downloadTask(with: url) { location, _, error in
                if let error {
                    continuation.resume(with: .failure(error))
                    return
                }
                guard let location else {
                    continuation.resume(with: .failure(URLSessionDownloadError()))
                    return
                }
                
                let localPath = FileHelper.getLocalPath(url: url)
                guard let localPath else {
                    continuation.resume(with: .failure(InvalidFileLocationError()))
                    return
                }
                
                let relativePath = localPath.relativePath
                do {
                    if FileManager.default.fileExists(atPath: relativePath) {
                        try FileManager.default.removeItem(atPath: relativePath)
                    }
                    try FileManager.default.moveItem(at: location, to: localPath)
                    continuation.resume(with: .success(localPath))
                } catch {
                    continuation.resume(with: .failure(error))
                }
            }
            .resume()
        }
    }
}
