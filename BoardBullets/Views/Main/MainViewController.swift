//
//  MainViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 3/26/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import IQKeyboardManager

class MainViewController: UIViewController {
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var getFullVersionButton: UIButton!
    
    @IBOutlet weak var submitAQuestionButton: UIButton!
    @IBOutlet weak var myPerformanceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().enable = true
        
        switch InAppPurchase.bought {
        case true:
            getFullVersionButton.hidden = true
        case false:
            submitAQuestionButton.hidden = true
            myPerformanceButton.hidden = true
        }
        
        addTextDismiss()
        view.endEditing(true)
    }
    
    @IBAction func didHitGetFullVersion() {
    }

    @IBAction func unwindToMain(segue: UIStoryboardSegue) {}
}
