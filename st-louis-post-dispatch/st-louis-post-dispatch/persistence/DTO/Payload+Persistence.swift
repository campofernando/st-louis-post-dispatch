//
//  Payload+Persistence.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 17/08/24.
//

import Foundation
import CoreData

extension Payload {
    init(managedObject: PayloadDTO) {
        self.id = managedObject.payloadId
        self.record = Record(managedObject: managedObject.record)
        if let metadataDTO = managedObject.metadata {
            self.metadata = Metadata(managedObject: metadataDTO)
        } else {
            metadata = nil
        }
    }
    
    func managedObject(context: NSManagedObjectContext) -> PayloadDTO {
        let payload = PayloadDTO(context: context)
        payload.payloadId = id
        payload.record = record.managedObject(context: context)
        payload.metadata = metadata?.managedObject(context: context)
        return payload
    }
}

extension Record {
    init(managedObject: RecordDTO) {
        self.headerLogo = managedObject.headerLogo
        self.subscription = Subscription(managedObject: managedObject.subscription)
    }
    
    func managedObject(context: NSManagedObjectContext) -> RecordDTO {
        let record = RecordDTO(context: context)
        record.headerLogo = headerLogo
        record.subscription = subscription.managedObject(context: context)
        return record
    }
}

extension Subscription {
    init(managedObject: SubscriptionDTO) {
        self.benefits = managedObject.benefits.compactMap { $0.benefit }
        self.coverImage = managedObject.coverImage
        self.disclaimer = managedObject.disclaimer
        self.offerPageStyle = managedObject.offerPageStyle
        self.subscribeSubtitle = managedObject.subscribeSubtitle
        self.subscribeTitle = managedObject.subscribeTitle
        self.offers = managedObject.offers.map { Offer(managedObject: $0) }
    }
    
    func managedObject(context: NSManagedObjectContext) -> SubscriptionDTO {
        let subscription = SubscriptionDTO(context: context)
        subscription.coverImage = coverImage
        subscription.disclaimer = disclaimer
        subscription.offerPageStyle = offerPageStyle
        subscription.subscribeSubtitle = subscribeSubtitle
        subscription.subscribeTitle = subscribeTitle
        let benefitsList = benefits.map { benefitStr in
            let benefit = BenefitsDTO(context: context)
            benefit.benefit = benefitStr
            return benefit
        }
        subscription.benefits = Set(benefitsList)
        let offersList = offers.map { $0.managedObject(context: context) }
        subscription.offers = Set(offersList)
        return subscription
    }
}

extension Offer {
    init(managedObject: OfferDTO) {
        self.description = managedObject.offerDescription
        self.price = managedObject.price
    }
    
    func managedObject(context: NSManagedObjectContext) -> OfferDTO {
        let offer = OfferDTO(context: context)
        offer.offerDescription = description
        offer.price = price
        return offer
    }
}

extension Metadata {
    init(managedObject: MetadataDTO) {
        self.createdAt = managedObject.createdAt
        self.name = managedObject.name
        self.readCountRemaining = Int(managedObject.readCountRemaining)
        self.timeToExpire = Int(managedObject.timeToExpire)
    }
    
    func managedObject(context: NSManagedObjectContext) -> MetadataDTO {
        let offer = MetadataDTO(context: context)
        offer.createdAt = createdAt
        offer.name = name
        if let readCountRemaining {
            offer.readCountRemaining = Int16(readCountRemaining)
        }
        if let timeToExpire {
            offer.timeToExpire = Int64(timeToExpire)
        }
        return offer
    }
}
