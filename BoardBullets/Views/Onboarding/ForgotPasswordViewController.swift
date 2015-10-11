//
//  ForgotPasswordViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 3/25/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import Parse

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: CircularEdgeTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
    }
    
    @IBAction func submitButtonWasHit() {
        PFUser.requestPasswordResetForEmailInBackground(emailTextField.text ?? "")
        PFUser.requestPasswordResetForEmailInBackground(emailTextField.text ?? "", block: { (success, error) in
            var alert: UIAlertController
            if success {
                alert = UIAlertController(title: "Check your email", message: "We've sent an email with a reset link to \(self.emailTextField.text), change your password then come back and try to log in", preferredStyle: .Alert)
            } else {
                let err = error!.userInfo["error"] as! String
                
                alert = UIAlertController(title: "Uh oh!", message: err.capitalizedString, preferredStyle: .Alert)
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        })
        
    }
    
    @IBAction func backButtonWasHit() {
        self.navigationController!.popViewControllerAnimated(true)
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        submitButtonWasHit()
        return true
    }
}