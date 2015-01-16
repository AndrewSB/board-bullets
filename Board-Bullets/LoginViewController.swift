//
//  LoginViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/5/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailLabel: CircularEdgeTextField!
    @IBOutlet weak var passwordLabel: CircularEdgeTextField!
    
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logInButtonHit(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(emailLabel.text, password:passwordLabel.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                self.appDelegate.switchToMain()
            } else {
                println(error)
            }
        }
    }
}
