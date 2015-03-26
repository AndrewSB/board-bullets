//
//  SignupViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/15/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var nameLabel: CircularEdgeTextField!
    @IBOutlet weak var emailLabel: CircularEdgeTextField!
    @IBOutlet weak var passwordLabel: CircularEdgeTextField!
    @IBOutlet weak var medicalSchoolLabel: CircularEdgeTextField!
    
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate


    override func viewDidLoad() {
        super.viewDidLoad()
        addTextDismiss()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signupButtonHit(sender: AnyObject) {
        let user = PFUser()
        user["name"] = nameLabel.text
        user.username = emailLabel.text
        user.email = emailLabel.text
        user.password = passwordLabel.text
        user["medicalSchool"] = medicalSchoolLabel.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                self.appDelegate.switchToMain()
            } else {
                var errorMessage = error.userInfo!["error"] as String
                
                errorMessage = errorMessage.stringByReplacingOccurrencesOfString("username", withString: "email", options: nil, range: Range(start: errorMessage.startIndex, end: errorMessage.endIndex))
                
                let alert = UIAlertController(title: "Uh oh!", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
                alert.addAction(action)
                
                self.presentViewController(alert, animated: true, completion: nil)

                println(error)// Show the errorString somewhere and let the user try again.
            }
        }
    }
}
