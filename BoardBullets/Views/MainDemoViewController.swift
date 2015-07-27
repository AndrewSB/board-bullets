//
//  MainDemoViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 7/23/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class MainDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addTextDismiss()
        view.endEditing(true)
        
        println("On the demo")
    }

    @IBAction func didHitGetApp() {
        InAppPurchase.bought = true
        (UIApplication.sharedApplication().delegate as! AppDelegate).switchToMain()
    }
    
    @IBAction func unwindToMainDemo(segue: UIStoryboardSegue) {}
}
