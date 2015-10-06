//
//  DemoQuizPickerViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 7/23/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

import Parse

class DemoQuizPickerViewController: UIViewController {

    @IBOutlet weak var learnAsYouGoButton: UIButton!
    @IBOutlet weak var timedButton: UIButton!
    @IBOutlet weak var numberOfQuestionsSegmentedController: UISegmentedControl!
    
    var quizData: [Question]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let query = PFQuery(className: "Questions")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock() {
            self.quizData = $0.0!.map { questionJSON -> Question in
                return Question(parseObject: questionJSON as! PFObject)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let twentyQuestionAlert = UIAlertController(title: "Twenty Demo Questions", message: "In this demo version of the app you get 20 demo questions to try out. The full version has over 1300", preferredStyle: .Alert)
        twentyQuestionAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        presentViewController(twentyQuestionAlert, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? DemoQuizViewController {
            
            print(self.numberOfQuestionsSegmentedController.selectedSegmentIndex)
            
            switch self.numberOfQuestionsSegmentedController.selectedSegmentIndex {
            case 0:
                destination.numberOfQuestions = 5
            case 1:
                destination.numberOfQuestions = 10
            case 2:
                destination.numberOfQuestions = 20
            default:
                fatalError("wut")
            }
            if timedButton.titleLabel?.font == UIFont(name: "HelveticaNeue", size: 24) {
                destination.timeTrail = true
            }
            
            destination.quizData = Array(quizData![0..<destination.numberOfQuestions])
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
    
    @IBAction func unwindToDemoQuizPicker(segue: UIStoryboardSegue) {}

}
