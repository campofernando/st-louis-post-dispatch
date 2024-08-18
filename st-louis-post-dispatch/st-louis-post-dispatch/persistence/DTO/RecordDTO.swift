//
//  RecordDTO.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 17/08/24.
//

import Foundation

extension RecordDTO {
    static private let defaultHeaderLogoString = "https://cdn.us-corp-qa-3.vip.tnqa.net//nativeapp.www.us-corp-qa-3.tnqa.net//content//tncms//assets//v3//media//9//e0//9e0dae9e-240b-11ef-9068-000c299ccbc9//6661be72a43be.image.png?resize=762%2C174"
    
    private var defaultHeaderLogoURL: URL {
        URL(string: RecordDTO.defaultHeaderLogoString)!
    }

    var headerLogo: URL {
        get {
            headerLogo_ ?? defaultHeaderLogoURL
        }
        set {
            headerLogo_ = newValue
        }
    }
    
    var subscription: SubscriptionDTO {
        get {
            subscription_!
        }
        set {
            subscription_ = newValue
        }
    }
}
