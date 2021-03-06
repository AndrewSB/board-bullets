//
//  UIStoryboardExtension.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 7/23/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit



extension UIStoryboard {
    
    enum Named: String {
        case Main = "Main"
        case Demo = "Demo"
        case Login = "Login"
    }
    
    class func initialIn(storyboard storyboardEnum: Named) -> UIViewController {
        let storyboardName = storyboardEnum.rawValue
        return UIStoryboard.initialIn(storyboard: storyboardName)
    }
    
    class func initialIn(storyboard storyboardNamed: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardNamed, bundle: NSBundle.mainBundle())
        return storyboard.instantiateInitialViewController()!
    }
    
}