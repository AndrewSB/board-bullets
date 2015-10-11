//
//  UIViewControllerExtension.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/5/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

extension UIViewController {
    func addTextDismiss() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "hideKeyboard:"))
    }
    
    func registerForKeyboard() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func deregisterForKeyboard() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func hideKeyboard(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func keyboardWasShown(id: AnyObject) {
        print("s")
    }
    
    func keyboardWillBeHidden(id: AnyObject) {
        print("sasd")
    }
    
    func addLoadingView() -> UIActivityIndicatorView {
        let aV = UIActivityIndicatorView(frame: CGRectMake(view.frame.width/2 - 11, view.frame.height/2 - 11, 11, 11))
        aV.startAnimating()
        aV.color = UIColor.grayColor()
        
        return aV
    }
}
