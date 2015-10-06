//
//  AppDelegate.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/4/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

import Fabric
import Crashlytics

import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.enableLocalDatastore()
        Parse.setApplicationId("ABXWdr3QElQxJ6JXPZ2kbLGe3RmPculkoMF2oA6x", clientKey: "TWIk4FCSGc1HXexXDxr7QaadCSZ0U66W5jlVkPg8")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        Fabric.with([Crashlytics()])
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 15
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        
        let loggedIn = PFUser.currentUser() != nil
        let boughtFullVersion = InAppPurchase.bought
        
        let storyboard = loggedIn ?
                                    boughtFullVersion ? UIStoryboard.Named.Main : UIStoryboard.Named.Demo
                                    : UIStoryboard.Named.Login
    
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = (UIStoryboard(name: storyboard.rawValue, bundle: NSBundle.mainBundle()).instantiateInitialViewController()!)
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
            return FBSDKApplicationDelegate.sharedInstance().application(application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    func switchToMain() {
        window?.rootViewController = UIStoryboard.initialIn(storyboard: UIStoryboard.Named.Main)
    }
    
    func switchToLogin() {
        window?.rootViewController = UIStoryboard.initialIn(storyboard: UIStoryboard.Named.Login)
    }

}

