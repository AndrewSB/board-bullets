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

    @IBOutlet weak var swipeHintView: UIView!
    
    var answers = [Int]()
    var timeTrail = false
    var numberOfQuestions = 10
    var allotedTime = Int()
    var quizData = [Question]()
    var curQuestion = 0
    var originalNextButtonWidth : CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizData = genQuiz(numberOfQuestions)
        loadQuestionInitial()
        configureTimer()
        configureQuestionNav()
        configureSwipeHint()
        configureSwipeGestures()
        
        originalNextButtonWidth = nextButton.frame.size.width
        
        
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
        
    }
    
    func loadQuestion(i: Int, isMovingForward: Bool) {
        
        nextButton.layer.opacity = 0
        if curQuestion == 0 {
            UIView.animateWithDuration(0.25, animations: {
                self.backButton.layer.opacity = 0
            })
            
        } else {
            UIView.animateWithDuration(0.25, animations: {
                self.backButton.layer.opacity = 1
            })
        }
        
        UIView.animateWithDuration(0.25, animations: {
            
            self.questionLabel.layer.opacity = 0
            self.option1Button.layer.opacity = 0
            self.option2Button.layer.opacity = 0
            self.option3Button.layer.opacity = 0
            
            if isMovingForward {
                self.questionLabel.frame.origin.x = self.questionLabel.frame.origin.x - 50
                self.option1Button.frame.origin.x = self.option1Button.frame.origin.x - 50
                self.option2Button.frame.origin.x = self.option2Button.frame.origin.x - 50
                self.option3Button.frame.origin.x = self.option3Button.frame.origin.x - 50
            } else {
                self.questionLabel.frame.origin.x = self.questionLabel.frame.origin.x + 50
                self.option1Button.frame.origin.x = self.option1Button.frame.origin.x + 50
                self.option2Button.frame.origin.x = self.option2Button.frame.origin.x + 50
                self.option3Button.frame.origin.x = self.option3Button.frame.origin.x + 50
            }
            
        }, completion: { animationFinished in
            for b in [self.option1Button, self.option2Button, self.option3Button] {
                b.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
            }
            self.questionLabel.text = self.quizData[i].question
            self.option1Button.setTitle(self.quizData[i].optionOne, forState: .Normal)
            self.option2Button.setTitle(self.quizData[i].optionTwo, forState: .Normal)
            self.option3Button.setTitle(self.quizData[i].optionThree, forState: .Normal)
            
            if isMovingForward {
                self.questionLabel.frame.origin.x = self.questionLabel.frame.origin.x + 100
                self.option1Button.frame.origin.x = self.option1Button.frame.origin.x + 100
                self.option2Button.frame.origin.x = self.option2Button.frame.origin.x + 100
                self.option3Button.frame.origin.x = self.option3Button.frame.origin.x + 100
            } else {
                self.questionLabel.frame.origin.x = self.questionLabel.frame.origin.x - 100
                self.option1Button.frame.origin.x = self.option1Button.frame.origin.x - 100
                self.option2Button.frame.origin.x = self.option2Button.frame.origin.x - 100
                self.option3Button.frame.origin.x = self.option3Button.frame.origin.x - 100
            }

            
            UIView.animateWithDuration(0.25, animations: {
                self.questionLabel.layer.opacity = 1
                self.option1Button.layer.opacity = 1
                self.option2Button.layer.opacity = 1
                self.option3Button.layer.opacity = 1
                
                if isMovingForward {
                    self.questionLabel.frame.origin.x = self.questionLabel.frame.origin.x - 50
                    self.option1Button.frame.origin.x = self.option1Button.frame.origin.x - 50
                    self.option2Button.frame.origin.x = self.option2Button.frame.origin.x - 50
                    self.option3Button.frame.origin.x = self.option3Button.frame.origin.x - 50
                } else {
                    self.questionLabel.frame.origin.x = self.questionLabel.frame.origin.x + 50
                    self.option1Button.frame.origin.x = self.option1Button.frame.origin.x + 50
                    self.option2Button.frame.origin.x = self.option2Button.frame.origin.x + 50
                    self.option3Button.frame.origin.x = self.option3Button.frame.origin.x + 50
                }
                
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
        
        if curQuestion == numberOfQuestions - 1 {
            nextButton.setBackgroundImage(nil, forState: .Normal)
            nextButton.setTitle("DONE", forState: .Normal)
            nextButton.sizeToFit()
        } else {
            nextButton.setBackgroundImage(UIImage(named: "next-arrow"), forState: .Normal)
            nextButton.setTitle("", forState: .Normal)
        }
        
        UIView.animateWithDuration(0.25, animations: {
            self.nextButton.layer.opacity = 1
        })
        
        playSwipeHintAnimation()
    }
    
    
    @IBAction func reviewButtonWasHit(sender: AnyObject) {
    }
    
    @IBAction func pauseButtonWasHit(sender: AnyObject) {
    }
    
    @IBAction func option1WasHit(sender: AnyObject) {
        quizData[curQuestion].chosen = 1
        handleSelection(option1Button)
        //Sarode next button animation/loadDone
    }
    
    @IBAction func option2WasHit(sender: AnyObject) {
        quizData[curQuestion].chosen = 2
        handleSelection(option2Button)
        //Sarode next button animation/loadDone
    }
    
    @IBAction func option3WasHit(sender: AnyObject) {
        quizData[curQuestion].chosen = 3
        handleSelection(option3Button)
        //Sarode next button animation/loadDone
    }
    
    @IBAction func backButtonWasHit(sender: AnyObject) {
        curQuestion--
        loadQuestion(curQuestion, isMovingForward: false)
    }
    
    @IBAction func nextButtonWasHit(sender: AnyObject) {
        
        
        if curQuestion == numberOfQuestions - 1 {
            performSegueWithIdentifier("segueToDone", sender: nil)
        } else {
            curQuestion++
            loadQuestion(curQuestion, isMovingForward: true)
        }
    }
    
    func configureQuestionNav() {
        backButton.layer.opacity = 0
        nextButton.layer.opacity = 0
 
    }
    
    func configureSwipeGestures() {
        //------------right  swipe gestures in view--------------//
        let swipeRight = UISwipeGestureRecognizer(target: self, action: Selector("rightSwiped"))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        //-----------left swipe gestures in view--------------//
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector("leftSwiped"))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func rightSwiped() {
        if backButton.layer.opacity != 0 {
            backButtonWasHit(self)
        }
    }
    
    func leftSwiped() {
        if nextButton.layer.opacity != 0 {
            nextButtonWasHit(self)
        }
    }
    
    func configureSwipeHint() {
        swipeHintView.layer.cornerRadius = 15
        swipeHintView.layer.backgroundColor = UIColor(red: 0.104, green: 0.457, blue: 0.734, alpha: 0.5).CGColor
        swipeHintView.layer.opacity = 0
    }
    
    func playSwipeHintAnimation() {
        self.swipeHintView.layer.opacity = 1
        UIView.animateWithDuration(0.25, delay: 0, options: .CurveEaseInOut, animations: {
            self.swipeHintView.layer.opacity = 0
            self.swipeHintView.frame.origin.x = self.swipeHintView.frame.origin.x - 88
        }, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? QuizDoneViewController {
            destination.questions = quizData
        }
    }
    
    @IBAction func unwindToQuiz(segue: UIStoryboardSegue) {
    }
}