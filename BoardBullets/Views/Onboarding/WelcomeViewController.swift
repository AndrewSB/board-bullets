//
//  LoginViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/5/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import Parse

class WelcomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addTextDismiss()
    }

    @IBAction func signInWithFbHit(sender: AnyObject) {
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email", "user_friends"], block: { (user, error) in
            if user == nil {
                NSLog("Uh oh. The user cancelled the Facebook login.")
            } else if user!.isNew {
                NSLog("User signed up and logged in through Facebook!")
                appDel.switchToMain()
            } else {
                NSLog("User logged in through Facebook!")
                appDel.switchToMain()
            }
        })

    }
    
    @IBAction func unwindToWelcome(segue: UIStoryboardSegue) {}
}