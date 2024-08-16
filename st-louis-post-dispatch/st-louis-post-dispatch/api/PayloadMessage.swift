//
//  PayloadMessage.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 16/08/24.
//

import Foundation

struct PayloadMessage: Codable {
    let id: String
    let record: Record
    let metadata: Metadata
}

struct Record: Codable {
    let headerLogo: URL
    let subscription: Subscription
    
    enum CodingKeys: String, CodingKey {
        case headerLogo = "header_logo"
        case subscription
    }
}

struct Subscription: Codable {
    let offerPageStyle: String
    let coverImage: URL
    let subscribeTitle: String
    let subscribeSubtitle: String
    let offers: Offers
    let benefits: [String]
    let disclaimer: String
    
    enum CodingKeys: String, CodingKey {
        case offerPageStyle = "offer_page_style"
        case coverImage = "cover_image"
        case subscribeTitle = "subscribe_title"
        case subscribeSubtitle = "subscribe_subtitle"
        case offers, benefits, disclaimer
    }
}

struct Offers: Codable {
    let id0: Offer
    let id1: Offer
}

struct Offer: Codable {
    let price: Double
    let description: String
}

struct Metadata: Codable {
    let name: String
    let readCountRemaining: Int
    let timeToExpire: Int
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case name, readCountRemaining, timeToExpire, createdAt
    }
}
