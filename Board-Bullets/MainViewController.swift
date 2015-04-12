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
        
        addTextDismiss()
        view.endEditing(true)
    }

    @IBAction func unwindToMain(segue: UIStoryboardSegue) {}
}
