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


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.enableLocalDatastore()
        
        if let keys = NSBundle.mainBundle().pathForResource("API-Keys", ofType: "plist") {
            let rootDict = NSDictionary(contentsOfFile: keys)
            let p = rootDict!["Parse"] as Dictionary<String, String>
            Parse.setApplicationId(p["ApplicationID"], clientKey: p["ClientKey"])
        } else {
            fatalError("You don't have access to the API Keys")
        }
        
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
        
        Fabric.with([Crashlytics()])
        
        let loggedIn = PFUser.currentUser() != nil
        let storyboard = loggedIn ? "Main" : "Login"
    
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let vc = UIStoryboard(name: storyboard, bundle: NSBundle.mainBundle()).instantiateInitialViewController() as UIViewController
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func switchToMain() {
        window?.rootViewController = (UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateInitialViewController() as UIViewController)
    }
    
    func logout() {
        window?.rootViewController = (UIStoryboard(name: "Login", bundle: NSBundle.mainBundle()).instantiateInitialViewController() as UIViewController)
    }

}

