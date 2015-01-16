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
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        addTextDismiss()
        indices = genRandom(numberOfQuestions, limit: data.count)
        super.viewDidLoad()
        loadQuestion(indices[0])
        let timer = NSTimer(timeInterval: 1.0, target: self, selector: "secondPassed:", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        reviewLabel.setTitle("60", forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func secondPassed(sender: AnyObject!) {
        if let t = reviewLabel.titleLabel?.text?.toInt() {
            if t == 0 {
                loadDone()
            } else {
                self.reviewLabel.setTitle("\(t-1)", forState: .Normal)
            }
        }
    }
    
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
    
    func loadQuestion(i: Int) {
        let r = genRandom(3, limit: 3)
        
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
    
    @IBAction func reviewButtonWasHit(sender: AnyObject) {
    }

    @IBAction func pauseButtonWasHit(sender: AnyObject) {
    }
    
    @IBAction func option1WasHit(sender: AnyObject) {
        option1Button.tintColor = UIColor.greenColor()
        answers.append(0)
        if answers.count < numberOfQuestions {
            loadQuestion(answers.count)
        } else {
            loadDone()
        }
    }
    
    @IBAction func option2WasHit(sender: AnyObject) {
        option2Button.tintColor = UIColor.greenColor()
        answers.append(1)
        if answers.count < numberOfQuestions {
            loadQuestion(answers.count)
        } else {
            loadDone()
        }
    }
    
    @IBAction func option3WasHit(sender: AnyObject) {
        option3Button.tintColor = UIColor.greenColor()
        answers.append(2)
        if answers.count < numberOfQuestions {
            loadQuestion(answers.count)
        } else {
            loadDone()
        }
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
