//
//  QuizViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/14/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    @IBOutlet weak var reviewLabel: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    
    let data: JSON = JSON(data: NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("data", ofType: "json")!)!)
    var answers = [Int]()
    var indices = [Int]()
    var timeTrail = false
    var numberOfQuestions = 10
    var allotedTime = 1
    
    override func viewDidLoad() {
        addTextDismiss()
        super.viewDidLoad()
        
        let quizData = genQuiz(numberOfQuestions)
        configureTimer()
    }

    func configureTimer() {
        allotedTime = numberOfQuestions * 12
        let timer = NSTimer(timeInterval: 1.0, target: self, selector: "secondPassed:", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        reviewLabel.setTitle("\(allotedTime)", forState: .Normal)
    }
    
    func secondPassed(sender: AnyObject!) {
        if let t = reviewLabel.titleLabel?.text?.toInt() {
            if t == 0 {
                loadDone()
            } else {
                self.reviewLabel.setTitle("\(self.timeTrail ? t-1 : t+1)", forState: .Normal)
                if self.reviewLabel.titleLabel?.text == "\(allotedTime)" {
                    self.reviewLabel.titleLabel?.textColor = UIColor.redColor()
                }
            }
        }
    }
    
    func loadQuestion(i: Int) {
        let r = genRandom(3, 3)
        
        questionLabel.text = data[i]["Question"].string!
        
        option1Button.setTitle(data[i][String(r[0]+1)].string!, forState: .Normal)
        option2Button.setTitle(data[i][String(r[1]+1)].string!, forState: .Normal)
        option3Button.setTitle(data[i][String(r[2]+1)].string!, forState: .Normal)
        
        println("\(option1Button.titleLabel?.text) || \(option2Button.titleLabel?.text) || \(option3Button.titleLabel?.text) || ")
    }
    
    func loadDone() {
        println("answer were \(answers)")
        performSegueWithIdentifier("segueToDone", sender: self)
    }
    
    func handleSelection(button: UIButton) {
        if button.titleLabel?.font == UIFont(name: "HelveticaNeue-Thin", size: 18) {
            for b in [option1Button, option2Button, option3Button] {
                b.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
            }
            button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 18)
        }
    }
    
    
    @IBAction func reviewButtonWasHit(sender: AnyObject) {
    }

    @IBAction func pauseButtonWasHit(sender: AnyObject) {
    }
    
    @IBAction func option1WasHit(sender: AnyObject) {
        handleSelection(option1Button)
        //Sarode next button animation/loadDone
    }
    
    @IBAction func option2WasHit(sender: AnyObject) {
        handleSelection(option2Button)
        //Sarode next button animation/loadDone
    }
    
    @IBAction func option3WasHit(sender: AnyObject) {
        handleSelection(option3Button)
        //Sarode next button animation/loadDone
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? QuizDoneViewController {
            for (index, element) in enumerate(indices) {
                let correctAnswer = data[element]["4"].string!
                let chosenAnswer = data[element][String(answers[index]+1)].string!
                println("correct: \(correctAnswer) \n chosen: \(chosenAnswer)")
                
                if chosenAnswer == correctAnswer {
                    println("correct")
                    destination.answers.append(true)
                } else {
                    destination.answers.append(false)
                }
            }
        }
    }
}
