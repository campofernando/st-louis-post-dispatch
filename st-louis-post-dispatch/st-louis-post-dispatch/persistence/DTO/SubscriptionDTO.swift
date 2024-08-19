//
//  SubscriptionDTO.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 17/08/24.
//

import Foundation

extension SubscriptionDTO {
    static private let defaultCoverImageString = "https://cdn.us-corp-qa-3.vip.tnqa.net/nativeapp.www.us-corp-qa-3.tnqa.net/content/tncms/assets/v3/media/8/18/818482c0-09d7-11ed-ad65-000c299ccbc9/62dac9c7602ba.image.jpg?resize=750%2C420"
    
    private var defaultCoverImageURL: URL {
        URL(string: SubscriptionDTO.defaultCoverImageString)!
    }
    
    var coverImage: URL {
        get {
            coverImage_ ?? defaultCoverImageURL
        }
        set {
            coverImage_ = newValue
        }
    }
    var disclaimer: String {
        get {
            disclaimer_ ?? PersistenceConstants.notFoundString
        }
        set {
            disclaimer_ = newValue
        }
    }
    
    static private let defaultOfferPageStyle = "square"
    
    var offerPageStyle: String {
        get {
            offerPageStyle_ ?? SubscriptionDTO.defaultOfferPageStyle
        }
        set {
            offerPageStyle_ = newValue
        }
    }
    
    var subscribeSubtitle: String {
        get {
            subscribeSubtitle_ ?? PersistenceConstants.notFoundString
        }
        set {
            subscribeSubtitle_ = newValue
        }
    }
    
    var subscribeTitle: String {
        get {
            subscribeTitle_ ?? PersistenceConstants.notFoundString
        }
        set {
            subscribeTitle_ = newValue
        }
    }
    
    var benefits: Set<BenefitsDTO> {
        get {
            (benefits_ as? Set<BenefitsDTO>) ?? []
        }
        set {
            benefits_ = newValue as NSSet
        }
    }
    
    var offers: Set<OfferDTO> {
        get {
            (offers_ as? Set<OfferDTO>) ?? []
        }
        set {
            offers_ = newValue as NSSet
        }
    }
}
