//
//  QuizPickerViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/16/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class QuizPickerViewController: UIViewController {
    @IBOutlet weak var learnAsYouGoButton: UIButton!
    @IBOutlet weak var timedButton: UIButton!
    @IBOutlet weak var numberOfQuestionsSegmentedController: UISegmentedControl!
    
    @IBOutlet weak var startQuizButton: UIButton!
    
    var quizData: [Question]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startQuizButton.setTitle("loading...", forState: .Normal)
        startQuizButton.userInteractionEnabled = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        startQuizButton.setTitle("loading...", forState: .Normal)
        startQuizButton.userInteractionEnabled = false
        
        Async.background {
            self.quizData = QuizHelper.genQuiz(20, vc: self)
            print(self.quizData!.count)
            Async.main {
                self.startQuizButton.setTitle("start quiz", forState: .Normal)
                self.startQuizButton.userInteractionEnabled = true
            }
        }
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? QuizViewController {
            switch self.numberOfQuestionsSegmentedController.selectedSegmentIndex {
            case 1:
                destination.numberOfQuestions = 10
                destination.quizData = self.quizData![0...9].map { $0 }
            case 2:
                destination.numberOfQuestions = 20
                destination.quizData = self.quizData!
            default:
                destination.numberOfQuestions = 5
                destination.quizData = self.quizData![0...4].map { $0 }
            }
            print("set things \(destination.quizData)")
            if timedButton.titleLabel?.font == UIFont(name: "HelveticaNeue", size: 24) {
                destination.timeTrail = true
            }
        }
    }

    @IBAction func learnAsYouGoButtonWasHit(sender: AnyObject) {
        if learnAsYouGoButton.titleLabel?.font == UIFont(name: "HelveticaNeue-Thin", size: 24) {
            learnAsYouGoButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 24)
            timedButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 24)
        }
    }
    
    @IBAction func timedButtonWasHit(sender: AnyObject) {
        if timedButton.titleLabel?.font == UIFont(name: "HelveticaNeue-Thin", size: 24) {
            timedButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 24)
            learnAsYouGoButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 24)
        }
    }
    @IBAction func startQuizButtonHit(sender: AnyObject) {
        
    }
    
    @IBAction func unwindToQuizPicker(segue: UIStoryboardSegue) {
    }
}
