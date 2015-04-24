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
        if !contains(a, i) {
            a.append(i)
        }
    }
    return a
}

func genQuiz(numberOfQuestions: Int) -> [Question] {
    var questions = [Question]()
    
    let questionQuery = PFQuery(className: "Questions")
    questionQuery.whereKey("approved", equalTo: true)
    questionQuery.maxCacheAge = 60*60*60*24*3
    
    let objects = questionQuery.findObjects()
    
    if let objects = objects {
        let randomlyChosenQuestions = genRandom(numberOfQuestions, objects.count)
        
        for (index, element) in enumerate(randomlyChosenQuestions) {
            let question = Question()
            let r = genRandom(3,3)
            
            question.question = objects[element]["question"] as! String
            question.optionOne = objects[element]["optionOne"] as! String
            question.optionTwo = objects[element]["optionTwo"] as! String
            question.optionThree = objects[element]["optionThree"] as! String
            
            if question.optionOne == objects[element]["answer"] as! String {
                question.answer = 1
            } else if question.optionTwo == objects[element]["answer"] as! String {
                question.answer = 2
            } else {
                question.answer = 3
            }
            
            questions.append(question)
        }
    }
    
    return questions
}
