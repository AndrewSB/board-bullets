//
//  LoginViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/5/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var emailLabel: CircularEdgeTextField!
    @IBOutlet weak var passwordLabel: CircularEdgeTextField!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTextDismiss()
        
        emailLabel.delegate = self
        passwordLabel.delegate = self
    }
    
    override func keyboardWasShown(id: AnyObject) {
        UIView.animateWithDuration(0.5, animations: {
            self.view.frame = CGRectMake(0, self.view.frame.origin.y - 150, self.view.frame.width, self.view.frame.height)
        })
    }
    
    override func keyboardWillBeHidden(id: AnyObject) {
        UIView.animateWithDuration(0.5, animations: {
            self.view.frame = CGRectMake(0, self.view.frame.origin.y + 150, self.view.frame.width, self.view.frame.height)
        })
    }

    @IBAction func logInButtonHit() {
        view.userInteractionEnabled = false
        let activity = addLoadingView()
        view.addSubview(activity)
        
        PFUser.logInWithUsernameInBackground(emailLabel.text ?? "", password: passwordLabel.text ?? "", block: { (user, error) in
            activity.removeFromSuperview()
            self.view.userInteractionEnabled = true
            
            if user != nil {
                self.appDelegate.switchToMain()
            } else {
                print(error!.description)
                let alert = UIAlertController(title: "Uh oh!", message: "Couldn't login, check your email and password", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
                alert.addAction(action)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }

        })
        
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case emailLabel:
            emailLabel.resignFirstResponder()
            passwordLabel.becomeFirstResponder()
        case passwordLabel:
            passwordLabel.resignFirstResponder()
            logInButtonHit()
        default: ()
        }
        
        return true
    }
}
