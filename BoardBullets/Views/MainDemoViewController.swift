//
//  MainDemoViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 7/23/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import StoreKit

class MainDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addTextDismiss()
        view.endEditing(true)
        
        print("On the demo")
    }

    @IBAction func didHitGetApp() {
        if !SKPaymentQueue.canMakePayments() {
            let failedPurchaseAlert = UIAlertController(title: "Uh oh!", message: "This device is unable to make purchases, take a look at your payment settings", preferredStyle: .Alert)
            failedPurchaseAlert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
            self.presentViewController(failedPurchaseAlert, animated: true, completion: nil)

        } else {
            InAppPurchase.sharedInstance.requestPurchase() {
                print("request Purchase callback called")
                if $0 {
                    let succedeedAlert = UIAlertController(title: "yay!", message: "you bought it. Should go to full version", preferredStyle: .Alert)
                    succedeedAlert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
                    self.presentViewController(succedeedAlert, animated: true, completion: {
                    
                    })
    
                } else {
                    let failedPurchaseAlert = UIAlertController(title: "Uh oh!", message: "Failed to make that purchase, are you sure you're connected to the internet?", preferredStyle: .Alert)
                    failedPurchaseAlert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
                    self.presentViewController(failedPurchaseAlert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func unwindToMainDemo(segue: UIStoryboardSegue) {}
}
