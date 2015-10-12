//
//  MainViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 3/26/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import StoreKit

import IQKeyboardManager
import Parse

class MainViewController: UIViewController {
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var getFullVersionButton: UIButton!
    
    @IBOutlet weak var submitAQuestionButton: UIButton!
    @IBOutlet weak var myPerformanceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().enable = true
        
        PFUser.currentUser()!.fetchInBackgroundWithBlock { _ in
            switch InAppPurchase.bought {
            case true:
                self.getFullVersionButton.hidden = true
            case false:
                self.submitAQuestionButton.hidden = true
                self.myPerformanceButton.hidden = true
            }
            
            self.addTextDismiss()
            self.view.endEditing(true)
        }
    }
    
    @IBAction func didHitGetFullVersion() {
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

    @IBAction func unwindToMain(segue: UIStoryboardSegue) {}
}
