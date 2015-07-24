//
//  Question.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/22/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import Foundation

import Parse

class Question {
    var question = String()
    var answer = Int()
    var optionOne = String()
    var optionTwo = String()
    var optionThree = String()
    var wikipediaLink = NSURL()
    var approved = Bool()
    
    
    var chosen = Int()
    var correct = Bool()
    
    init() {}
    
    func isCorrect() {
        correct = answer == chosen
    }
    
    init(parseObject: PFObject) {
        self.question = parseObject["question"] as! String
        self.optionOne = parseObject["optionOne"] as! String
        self.optionTwo = parseObject["optionTwo"] as! String
        self.optionThree = parseObject["optionThree"] as! String
        
        self.wikipediaLink = NSURL(string: parseObject["Wikipedia"] as! String)!
        
        self.approved = parseObject["approved"] as! Bool// == 1 ? true : false
        
        if self.optionOne == parseObject["answer"] as! String {
            self.answer = 1
        } else if self.optionTwo == parseObject["answer"] as! String {
            self.answer = 2
        } else {
            self.answer = 3
        }
        
    }
}