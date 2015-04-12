//
//  QuizHelper.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/22/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import Foundation

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
    let indices = genRandom(numberOfQuestions, data.count)
    
    for (index, element) in enumerate(indices) {
        let question = Question()
        let r = genRandom(3,3)
        
        question.question = data[element]["Question"].string!
        question.optionOne = data[element][String(r[0]+1)].string!
        question.optionTwo = data[element][String(r[1]+1)].string!
        question.optionThree = data[element][String(r[2]+1)].string!
        
        if question.optionOne == data[element]["4"].string {
            question.answer = 1
        } else if question.optionTwo == data[element]["4"].string {
            question.answer = 2
        } else {
            question.answer = 3
        }
        
        questions.append(question)
    }
    return questions
}
