//
//  AppDelegate.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/4/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

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
        
        return true
    }

}

