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
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var answers = [Int]()
    var timeTrail = false
    var numberOfQuestions = 10
    var allotedTime = Int()
    var quizData = [Question]()
    var curQuestion = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizData = genQuiz(numberOfQuestions)
        loadQuestionInitial()
        configureTimer()
    }
    
    func configureTimer() {
        allotedTime = numberOfQuestions * 12
        let timer = NSTimer(timeInterval: 1.0, target: self, selector: "secondPassed:", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        reviewLabel.setTitle("\(self.timeTrail ? allotedTime : 0)", forState: .Normal)
    }
    
    func secondPassed(sender: AnyObject!) {
        if let t = reviewLabel.titleLabel?.text?.toInt() {
            self.reviewLabel.setTitle("\(self.timeTrail ? t-1 : t+1)", forState: .Normal)
            if self.reviewLabel.titleLabel?.text == "\(allotedTime)" {
                self.reviewLabel.titleLabel?.textColor = UIColor.redColor()
            }
            
            if reviewLabel.titleLabel?.text?.toInt()! == 0 {
                loadDone()
            }
            
            if (t > allotedTime) {
                reviewLabel.titleLabel?.textColor = UIColor.redColor()
            }
            
        }
    }
    
    func loadQuestionInitial() {
        
        
        questionLabel.text = quizData[0].question
        option1Button.setTitle(quizData[0].optionOne, forState: .Normal)
        option2Button.setTitle(quizData[0].optionTwo, forState: .Normal)
        option3Button.setTitle(quizData[0].optionThree, forState: .Normal)
        
        backButton.layer.opacity = 0
        nextButton.layer.opacity = 0
        
    }
    
    func loadQuestion(i: Int) {
        
        nextButton.layer.opacity = 0
        if curQuestion == 0 {
            backButton.layer.opacity = 0
        } else {
            backButton.layer.opacity = 1
        }
        
        UIView.animateWithDuration(0.25, animations: {
            
            self.questionLabel.layer.opacity = 0
            self.option1Button.layer.opacity = 0
            self.option2Button.layer.opacity = 0
            self.option3Button.layer.opacity = 0
            
        }, completion: { animationFinished in
            for b in [self.option1Button, self.option2Button, self.option3Button] {
                b.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
            }
            self.questionLabel.text = self.quizData[i].question
            self.option1Button.setTitle(self.quizData[i].optionOne, forState: .Normal)
            self.option2Button.setTitle(self.quizData[i].optionTwo, forState: .Normal)
            self.option3Button.setTitle(self.quizData[i].optionThree, forState: .Normal)
            
            UIView.animateWithDuration(0.25, animations: {
                self.questionLabel.layer.opacity = 1
                self.option1Button.layer.opacity = 1
                self.option2Button.layer.opacity = 1
                self.option3Button.layer.opacity = 1
                
            })
                
        })
        
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
        
        UIView.animateWithDuration(0.25, animations: {
            self.nextButton.layer.opacity = 1
        })
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
    
    @IBAction func backButtonWasHit(sender: AnyObject) {
        curQuestion--
        loadQuestion(curQuestion)
    }
    
    @IBAction func nextButtonWasHit(sender: AnyObject) {
        curQuestion++
        loadQuestion(curQuestion)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? QuizDoneViewController {
            destination.questions = quizData
        }
    }
}