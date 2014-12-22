//
//  LoadingViewController.swift
//  board bullets
//
//  Created by Andrew Breckenridge on 12/21/14.
//  Copyright (c) 2014 asb. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (PFUser.currentUser() != nil) {
            println("Logged in")
        } else {
            println("Not logged in")
        }
    }
}
