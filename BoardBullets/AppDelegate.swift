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
import Bolts
import Async

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.enableLocalDatastore()
        Parse.setApplicationId("ABXWdr3QElQxJ6JXPZ2kbLGe3RmPculkoMF2oA6x", clientKey: "TWIk4FCSGc1HXexXDxr7QaadCSZ0U66W5jlVkPg8")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions == nil ? [NSObject: AnyObject]() : launchOptions!)
        
        Fabric.with([Crashlytics()])
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 15
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        
        let loggedIn = PFUser.currentUser() != nil
        let storyboard = loggedIn ? "Main" : "Login"
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = FakeLaunchViewController()
        self.window?.makeKeyAndVisible()
        
        let completion = {
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            self.window?.rootViewController = (UIStoryboard(name: storyboard, bundle: NSBundle.mainBundle()).instantiateInitialViewController()!)
            self.window?.makeKeyAndVisible()
        }
        
        if loggedIn {
            PFUser.currentUser()!.fetchInBackgroundWithBlock { _ in
                completion()
            }
        } else {
            completion()
        }
        
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
        window?.rootViewController = (UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateInitialViewController()!)
    }
    
    func switchToLogin() {
        window?.rootViewController = (UIStoryboard(name: "Login", bundle: NSBundle.mainBundle()).instantiateInitialViewController()!)
    }
    
}

