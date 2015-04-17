//
//  SignupViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/15/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController {
    @IBOutlet weak var nameLabel: CircularEdgeTextField!
    @IBOutlet weak var emailLabel: CircularEdgeTextField!
    @IBOutlet weak var passwordLabel: CircularEdgeTextField!
    @IBOutlet weak var medicalSchoolLabel: CircularEdgeTextField!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate


    override func viewDidLoad() {
        super.viewDidLoad()
        addTextDismiss()
        registerForKeyboard()
    }

    override func keyboardWasShown(id: AnyObject) {
        super.keyboardWasShown(id)
        
        UIView.animateWithDuration(0.5, animations: {
            self.view.frame = CGRectMake(0, self.view.frame.origin.y - 160, self.view.frame.width, self.view.frame.height)
        })
    }
    
    override func keyboardWillBeHidden(id: AnyObject) {
        super.keyboardWillBeHidden(id)
        
        UIView.animateWithDuration(0.5, animations: {
            self.view.frame = CGRectMake(0, self.view.frame.origin.y + 160, self.view.frame.width, self.view.frame.height)
        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        resignFirstResponder()
        deregisterForKeyboard()
    }

    @IBAction func signupButtonHit(sender: AnyObject) {
        let user = PFUser()
        user["name"] = nameLabel.text
        user.username = emailLabel.text
        user.email = emailLabel.text
        user.password = passwordLabel.text
        user["medicalSchool"] = medicalSchoolLabel.text
        
        view.userInteractionEnabled = false
        let activity = addLoadingView()
        view.addSubview(activity)
        
        
        user.signUpInBackgroundWithBlock { (user, error) in
            self.view.userInteractionEnabled = true
            activity.removeFromSuperview()
            
            if error == nil {
                self.appDelegate.switchToMain()
            } else {
                var errorMessage = error!.userInfo!["error"] as! String
                
                errorMessage = errorMessage.stringByReplacingOccurrencesOfString("username", withString: "email", options: nil, range: Range(start: errorMessage.startIndex, end: errorMessage.endIndex))

                
                let alert = UIAlertController(title: "Uh oh!", message: errorMessage.capitalizedString, preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
                alert.addAction(action)
                
                self.presentViewController(alert, animated: true, completion: nil)

                println(error)// Show the errorString somewhere and let the user try again.
            }
        }
    }
}
