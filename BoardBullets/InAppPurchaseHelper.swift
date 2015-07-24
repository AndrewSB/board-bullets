//
//  InAppPurchase.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 7/4/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import StoreKit

import Parse
import Bolts


// Look at all these observers. I LOVE Swift #nogettersorsetters
class InAppPurchase: NSObject {
    static let productIdentifier = "AllContentQuestions"
    static let userStoreKey = "boughttheapp"
    
    class var bought: Bool {
        get {
            if let boughtBool = NSUserDefaults.standardUserDefaults().objectForKey(self.userStoreKey) as? Bool {
                return boughtBool
            }
            return false
        }
        set {
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: self.userStoreKey)
        }
    }
    
    class var boughtFromParse: Bool {
        get {
        if let parseUser = PFUser.currentUser() {
            if let remoteBought = parseUser["bought"] as? Bool {
                return remoteBought
            }
        }
        return false
        }
        set {
            if let parseUser = PFUser.currentUser() {
                parseUser["bought"] = newValue as AnyObject
            }
        }
    }
    
    class var boughtProductRequest: SKRequest {
        get {
            return SKRequest()
        }
    }
}

extension InAppPurchase: SKRequestDelegate {
    func requestDidFinish(request: SKRequest!) {
        println("request did finish")
    }
    
    func request(request: SKRequest!, didFailWithError error: NSError!) {
        println("failed to request")
    }
    
}
