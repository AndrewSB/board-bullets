//
//  Delay.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 7/23/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import Foundation

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}