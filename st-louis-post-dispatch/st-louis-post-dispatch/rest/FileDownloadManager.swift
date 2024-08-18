//
//  FileDownloadManager.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 18/08/24.
//

import Foundation

enum FileHelper {
    static private let fakeUrl = "cdn.us-corp-qa-3.vip.tnqa.net//nativeapp.www.us-corp-qa-3.tnqa.net//content//tncms//assets//v3//media//9//e0//9e0dae9e-240b-11ef-9068-000c299ccbc9//6661be72a43be.image.png"
    static let testUrl = "https://cdn.us-corp-qa-3.vip.tnqa.net//nativeapp.www.us-corp-qa-3.tnqa.net//content//tncms//assets//v3//media//9//e0//9e0dae9e-240b-11ef-9068-000c299ccbc9//6661be72a43be.image.png?resize=762%2C174"
    
    static func getLocalPath(url: URL) -> URL? {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectoryURL.appendingPathComponent(url.lastPathComponent)
    }
    
    static func getMockLocalUrl() throws -> URL {
        guard let url = URL(string: fakeUrl),
              let localUrl = getLocalPath(url: url) else {
            throw URLSession.InvalidURLRequestError()
        }
        return localUrl
    }
}

struct FileDownloadManager {
    private let client: HttpClient
    
    init(client: HttpClient) {
        self.client = client
    }
    
    func downloadFile(from path: String) async throws -> String {
        let url = URL(string: path)
        let location = try await client.downloadFile(fromUrl: url)
        return location.relativePath
    }
}
