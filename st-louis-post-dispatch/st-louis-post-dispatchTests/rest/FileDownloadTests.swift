//
//  FileDownloadTests.swift
//  st-louis-post-dispatchTests
//
//  Created by Fernando Campo Garcia on 18/08/24.
//

import XCTest
@testable import st_louis_post_dispatch

final class FileDownloadTests: XCTestCase {

    var httpClient: HttpClient!
    var downloadManager: FileDownloadManager!
    
    override func setUpWithError() throws {
        httpClient = URLSession(configuration: .default)
        downloadManager = FileDownloadManager(client: httpClient)
    }
    
    override func tearDownWithError() throws {
        httpClient = nil
        downloadManager = nil
    }

    func testDownloadSuccess() async throws {
        let fileName = URL(string: FileHelper.testUrl)!.lastPathComponent
        let localPath = try await downloadManager.downloadFile(from: FileHelper.testUrl)
        let savedFileName = String(localPath.split(separator: "/", omittingEmptySubsequences: true).last!)
        XCTAssertFalse(localPath.isEmpty)
        XCTAssertEqual(savedFileName, fileName)
    }
}
