//
//  PayloadMessage.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 16/08/24.
//

import Foundation

struct PayloadMessage: Codable {
    let id: String?
    let record: RecordMessage?
    let metadata: MetadataMessage?
}

struct RecordMessage: Codable {
    let headerLogo: URL?
    let subscription: SubscriptionMessage?
    
    enum CodingKeys: String, CodingKey {
        case headerLogo = "header_logo"
        case subscription
    }
}

struct SubscriptionMessage: Codable {
    let offerPageStyle: String?
    let coverImage: URL?
    let subscribeTitle: String?
    let subscribeSubtitle: String?
    let offers: OffersMessage?
    let benefits: [String]?
    let disclaimer: String?
    
    enum CodingKeys: String, CodingKey {
        case offerPageStyle = "offer_page_style"
        case coverImage = "cover_image"
        case subscribeTitle = "subscribe_title"
        case subscribeSubtitle = "subscribe_subtitle"
        case offers, benefits, disclaimer
    }
}

struct OffersMessage: Codable {
    let id0: OfferMessage?
    let id1: OfferMessage?
}

struct OfferMessage: Codable {
    let price: Double?
    let description: String?
}

struct MetadataMessage: Codable {
    let name: String?
    let readCountRemaining: Int?
    let timeToExpire: Int?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case name, readCountRemaining, timeToExpire, createdAt
    }
}
