//
//  UIViewControllerExtension.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/5/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

extension UIViewController {
    func addTextBarObserver() {
        view.addGestureRecognizer(UIGestureRecognizer(target: self, action: "hideKeyboard:"))
    }
    
    func hideKeyboard(sender: AnyObject) {
        view.endEditing(true)
    }
}
