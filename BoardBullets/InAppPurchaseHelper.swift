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
    static let sharedInstance = InAppPurchase()
    
    static let productIdentifier = "com.boardbullets.allcontent"
    static let userStoreKey = "boughttheapp"
    
    var completionCallback: ((Bool) -> Void)!
    var completedPurchase = true
    
    class var bought: Bool {
        get {
            if let boughtBool = NSUserDefaults.standardUserDefaults().objectForKey(self.userStoreKey) as? Bool {
                print(boughtBool ? "bought" : "not bought", terminator: "")
                return boughtBool
            }
            print("not bought")
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
    
    func requestPurchase(completion: ((Bool) -> Void)) {
        completionCallback = completion
        
        let productRequest = SKProductsRequest(productIdentifiers: [InAppPurchase.productIdentifier])
        productRequest.delegate = self
        completedPurchase = false
        productRequest.start()
    }
}

extension InAppPurchase: SKProductsRequestDelegate {
    func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        if response.products.count > 0 {
            let product = response.products[0]
            let payment = SKPayment(product: product)
            SKPaymentQueue.defaultQueue().addPayment(payment)
        } else {
            completedPurchase = true
            print("no products were returned")
            completionCallback(false)
        }
    }
}

extension InAppPurchase: SKPaymentTransactionObserver {
    func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .Failed, .Deferred:
                print("transaction was \(transaction.transactionState)")
                completionCallback(false)
            case .Purchased, .Purchasing, .Restored:
                completionCallback(true)
            }
            completedPurchase = true
        }
        
        if !completedPurchase {
            print("transaction queue returned no transactions")
            completedPurchase = true
            completionCallback(false)
        }
    }
}