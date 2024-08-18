//
//  OfferDTO.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 17/08/24.
//

import Foundation

extension OfferDTO {
    var offerDescription: String {
        get {
            offerDescription_ ?? PersistenceConstants.notFoundString
        }
        set {
            offerDescription_ = newValue
        }
    }
}
