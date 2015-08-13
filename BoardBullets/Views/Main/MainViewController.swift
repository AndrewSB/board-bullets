//
//  MainViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 3/26/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().enable = true
        
        addTextDismiss()
        view.endEditing(true)
        
        print("On the main")
    }

    @IBAction func unwindToMain(segue: UIStoryboardSegue) {}
}
