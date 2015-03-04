//
//  LoginViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/5/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTextDismiss()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("welcome appeared")
    }
    
    @IBAction func logInHit(sender: AnyObject) {
        
    }

    @IBAction func signUpHit(sender: AnyObject) {
    
    }

    @IBAction func signInWithFbHit(sender: AnyObject) {
        println("llol")
        PFFacebookUtils.logInWithPermissions(["public_profile", "email", "user_friends"], {
            (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                NSLog("Uh oh. The user cancelled the Facebook login.")
            } else if user.isNew {
                NSLog("User signed up and logged in through Facebook!")
                self.appDelegate.switchToMain()
            } else {
                NSLog("User logged in through Facebook!")
                self.appDelegate.switchToMain()
            }
        })

    }
    
    @IBAction func unwindToWelcome(segue: UIStoryboardSegue) {}
}