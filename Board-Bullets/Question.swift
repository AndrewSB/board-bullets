//
//  Question.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/22/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import Foundation

class Question {
    var question = String()
    var answer = Int()
    var optionOne = String()
    var optionTwo = String()
    var optionThree = String()
    
    var chosen = Int()
    var correct = Bool()
    
    init() {}
    
    func isCorrect() {
        correct = answer == chosen
    }
}