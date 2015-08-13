//
//  QuizHelper.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/22/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import Foundation
import Parse

let data: JSON = JSON(data: NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("data", ofType: "json")!)!)

func genRandom(count: Int, limit: Int) -> [Int] {
    var a = [Int]()
    while a.count != count {
        let i = Int(arc4random_uniform(UInt32(limit)))
        if !a.contains(i) {
            a.append(i)
        }
    }
    return a
}

func genQuiz(numberOfQuestions: Int) -> [Question] {
    var questions = [Question]()
    
    let questionQuery = PFQuery(className: "Questions")
    questionQuery.whereKey("approved", equalTo: true)
    questionQuery.maxCacheAge = 60*60*60*24
    
    let objects = questionQuery.findObjects()
    
    if let objects = objects {
        let randomlyChosenQuestions = genRandom(numberOfQuestions, limit: objects.count)
        
        for (index, element) in randomlyChosenQuestions.enumerate() {
            questions.append(Question(parseObject: objects[element] as! PFObject))
        }
    }
    
    return questions
}
