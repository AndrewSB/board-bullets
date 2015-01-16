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
        
        addParse(launchOptions)
        Fabric.with([Crashlytics()])
        
        
        PFUser.logOut()
        let loggedIn = PFUser.currentUser() != nil
        let storyboard = loggedIn ? "Main" : "Login"
    
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = (UIStoryboard(name: storyboard, bundle: NSBundle.mainBundle()).instantiateInitialViewController() as UIViewController)
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func addParse(lo: [NSObject: AnyObject]?) {
        Parse.enableLocalDatastore()
        
        if let keys = NSBundle.mainBundle().pathForResource("API-Keys", ofType: "plist") {
            let rootDict = NSDictionary(contentsOfFile: keys)
            let p = rootDict!["Parse"] as Dictionary<String, String>
            Parse.setApplicationId(p["ApplicationID"], clientKey: p["ClientKey"])
        } else {
            fatalError("You don't have access to the API Keys")
        }
        
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(lo, block: nil)
        
        PFFacebookUtils.initializeFacebook()
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String, annotation: AnyObject?) -> Bool {
            return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication, withSession:PFFacebookUtils.session())
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBAppCall.handleDidBecomeActiveWithSession(PFFacebookUtils.session())
    }
    
    func switchToMain() {
        window?.rootViewController = (UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateInitialViewController() as UIViewController)
    }
    
    func switchToLogin() {
        window?.rootViewController = (UIStoryboard(name: "Login", bundle: NSBundle.mainBundle()).instantiateInitialViewController() as UIViewController)
    }

}

