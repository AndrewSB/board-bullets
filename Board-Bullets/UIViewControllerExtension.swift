//
//  UIViewControllerExtension.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/5/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

extension UIViewController {
    func addKeyboardObserver() {
        
    }
    
    func addTextDismiss() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "hideKeyboard:"))
    }
    
    func registerForKeyboard() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: <#String?#>, object: <#AnyObject?#>)
    }
    
    func deregisterForKeyboard() {
        
    }
    
    - (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(keyboardWasShown:)
    name:UIKeyboardDidShowNotification
    object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(keyboardWillBeHidden:)
    name:UIKeyboardWillHideNotification
    object:nil];
    
    }
    
    - (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
    name:UIKeyboardDidHideNotification
    object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
    name:UIKeyboardWillHideNotification
    object:nil];
    
    }
    
    
    func hideKeyboard(sender: AnyObject) {
        println("lol")
        view.endEditing(true)
    }
}
