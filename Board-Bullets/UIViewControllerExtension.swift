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
    
    func hideKeyboard(sender: AnyObject) {
        println("lol")
        view.endEditing(true)
    }
}
