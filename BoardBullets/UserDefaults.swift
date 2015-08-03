//
//  NSUserDefaultHelper.swift
//  The Mouve
//
//  Created by Andrew Breckenridge on 4/25/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import Foundation
import CoreLocation

class UserDefaults {
    static let get = NSUserDefaults.standardUserDefaults().objectFor
    static let set = NSUserDefaults.standardUserDefaults().set
    
    enum UserDefaultKey: String {
        case Correct = "Performance_correct"
        case Answered = "Performace_answered"
    }
    
    class var performance: (correct: Int, answered: Int) {
        get {
            let correct = get(.Correct) as? Int
            let answered = get(.Answered) as? Int
            if let correct = correct, answered = answered {
                return (correct, answered)
            } else {
                return (0, 0)
            }
        }
        set {
            set(newValue.correct, forKey: .Correct)
            set(newValue.answered, forKey: .Answered)
        }
    }
}

extension NSUserDefaults {
    func objectFor(key: UserDefaults.UserDefaultKey) -> AnyObject? {
        return objectForKey(key.rawValue)
    }
    
    func set(value: AnyObject?, forKey: UserDefaults.UserDefaultKey) {
        setObject(value, forKey: forKey.rawValue)
    }
}