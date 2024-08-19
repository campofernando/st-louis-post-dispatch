//
//  ViewModel.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 16/08/24.
//

import Foundation
import CoreData
import Combine

class ViewModel {
    private let payloadRepository: PayloadRepository
    private let fileDownloadManager: FileDownloadManager
    var subscriptionBinding = PassthroughSubject<Subscription, Never>()
    var headerImageBinding =  PassthroughSubject<String, Never>()
    var coverImageBinding =  PassthroughSubject<String, Never>()
    
    init(context: NSManagedObjectContext, httpClient: HttpClient) {
        self.payloadRepository = PayloadRepository(context: context, httpClient: httpClient)
        fileDownloadManager = FileDownloadManager(client: URLSession(configuration: .default))
    }
    
    func getViewElements() {
        Task { [weak self] in
            guard let self else {
                fatalError("Invalidated self")
            }
            do {
                let payload = try await self.payloadRepository.getPayload()
                self.onPayloadReceived(payload: payload)
            } catch {
                print(error)
            }
        }
    }
    
    private func onPayloadReceived(payload: Payload) {
        subscriptionBinding.send(payload.record.subscription)
        getImages(payload: payload)
    }
    
    private func getImages(payload: Payload) async throws -> (String, String) {
        async let headerImagePath = try self.fileDownloadManager.downloadFile(
            from: payload.record.headerLogo
        )
        async let coverImagePath = try self.fileDownloadManager.downloadFile(
            from: payload.record.subscription.coverImage
        )
        return try await (headerImagePath, coverImagePath)
    }
    
    private func getImages(payload: Payload) {
        Task { [weak self] in
            guard let self else {
                fatalError()
            }
            do {
                let (headerImagePath, coverImagePath) = try await getImages(payload: payload)
                headerImageBinding.send(headerImagePath)
                coverImageBinding.send(coverImagePath)
            } catch {
                print(error)
            }
        }
    }
}
