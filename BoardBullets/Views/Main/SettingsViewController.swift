//
//  SettingsViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/16/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {
    @IBOutlet weak var oldPasswordTextField: CircularEdgeTextField!
    @IBOutlet weak var newPasswordTextField: CircularEdgeTextField!
    @IBOutlet weak var confirmNewPasswordTextField: CircularEdgeTextField!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

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

    @IBAction func changePasswordButtonHit(sender: AnyObject) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .Alert)
        if PFUser.currentUser()!.password == oldPasswordTextField.text {
            if newPasswordTextField.text == confirmNewPasswordTextField.text {
                PFUser.currentUser()!.password = newPasswordTextField.text
                PFUser.currentUser()!.save()
                alert.title = "Your password was changed!"
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                alert.title = "Uh oh!"
                alert.message = "Your two new passwords don't match"
                self.presentViewController(alert, animated: true, completion: nil)
            }
        } else {
            alert.title = "Uh oh!"
            alert.message = "The password you entered is incorrect"
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func didHitSocialButton(sender: UIButton) {
        var url: String?
        
        switch sender.titleLabel!.text! {
        case "website":
            url = "http://medboardbullets.com"
        case "facebook":
            url = "http://facebook.com/boardbullets"
        case "instagram":
            url = "https://instagram.com/boardbullets/"
        case "twitter":
            url = "https://twitter.com/BoardBullets"
        default: ()
        }
        
        if let url = url {
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        }
    }
    
    @IBAction func logoutButtonHit(sender: AnyObject) {
        PFUser.logOut()
        appDelegate.switchToLogin()
    }
}
