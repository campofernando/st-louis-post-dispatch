//
//  Payload.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 17/08/24.
//

import Foundation

struct Payload {
    let id: String
    let record: Record
    let metadata: Metadata?
}

struct Record {
    let headerLogo: URL
    let subscription: Subscription
}

struct Subscription {
    let offerPageStyle: String
    let coverImage: URL
    let subscribeTitle: String
    let subscribeSubtitle: String
    let offers: [Offer]
    let benefits: [String]
    let disclaimer: String
}

struct Offer {
    let price: Double
    let description: String
}

struct Metadata {
    let name: String?
    let readCountRemaining: Int?
    let timeToExpire: Int?
    let createdAt: String?
}
