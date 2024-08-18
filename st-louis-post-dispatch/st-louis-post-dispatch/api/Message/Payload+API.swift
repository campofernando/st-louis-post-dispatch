//
//  Payload+API.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 17/08/24.
//

import Foundation

extension PayloadMessage {
    func getModel() throws -> Payload {
        guard let id, let record else {
            throw PayloadMapper.InvalidPayloadMessage()
        }
        return Payload(
            id: id,
            record: try record.getModel(),
            metadata: metadata?.getModel()
        )
    }
}

extension RecordMessage {
    func getModel() throws -> Record {
        guard let headerLogo, let subscription else {
            throw PayloadMapper.InvalidPayloadMessage()
        }
        return Record(
            headerLogo: headerLogo,
            subscription: try subscription.getModel()
        )
    }
}

extension SubscriptionMessage {
    func getModel() throws -> Subscription {
        guard let offerPageStyle,
              let coverImage,
              let subscribeTitle,
              let subscribeSubtitle,
              let disclaimer else {
            throw PayloadMapper.InvalidPayloadMessage()
        }
        return Subscription(
            offerPageStyle: offerPageStyle,
            coverImage: coverImage,
            subscribeTitle: subscribeTitle,
            subscribeSubtitle: subscribeSubtitle,
            offers: try offers?.getModel() ?? [],
            benefits: benefits ?? [],
            disclaimer: disclaimer
        )
    }
}

extension OffersMessage {
    func getModel() throws -> [Offer] {
        var offers = [Offer]()
        if let id0 {
            try offers.append(id0.getModel())
        }
        if let id1 {
            try offers.append(id1.getModel())
        }
        return offers
    }
}

extension OfferMessage {
    func getModel() throws -> Offer {
        guard let description, let price else {
            throw PayloadMapper.InvalidPayloadMessage()
        }
        return Offer(
            price: price,
            description: description
        )
    }
}

extension MetadataMessage {
    func getModel() -> Metadata {
        return Metadata(
            name: self.name,
            readCountRemaining: self.readCountRemaining,
            timeToExpire: self.timeToExpire,
            createdAt: self.createdAt
        )
    }
}
