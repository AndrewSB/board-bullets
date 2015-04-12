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
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTextDismiss()
    }

    @IBAction func logInButtonHit(sender: AnyObject) {
        view.userInteractionEnabled = false
        let activity = addLoadingView()
        view.addSubview(activity)
        
        PFUser.logInWithUsernameInBackground(emailLabel.text, password:passwordLabel.text) {
            (user: PFUser!, error: NSError!) -> Void in
            activity.removeFromSuperview()
            self.view.userInteractionEnabled = true
            
            if user != nil {
                self.appDelegate.switchToMain()
            } else {
                println(error.description)
                let alert = UIAlertController(title: "Uh oh!", message: "Couldn't login, check your email and password", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
                alert.addAction(action)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
}
