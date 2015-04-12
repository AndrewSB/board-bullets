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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? QuizViewController {
            switch self.numberOfQuestionsSegmentedController.selectedSegmentIndex {
            case 1:
                destination.numberOfQuestions = 10
            case 2:
                destination.numberOfQuestions = 20
            default:
                destination.numberOfQuestions = 5
            }
            if timedButton.titleLabel?.font == UIFont(name: "HelveticaNeue", size: 24) {
                destination.timeTrail = true
            }
        }
    }

    @IBAction func learnAsYouGoButtonWasHit(sender: AnyObject) {
        if learnAsYouGoButton.titleLabel?.font == UIFont(name: "HelveticaNeue-Thin", size: 24) {
            learnAsYouGoButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 24)
            timedButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 24)
        } else {
//            learnAsYouGoButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 24)
        }
    }
    @IBAction func timedButtonWasHit(sender: AnyObject) {
        if timedButton.titleLabel?.font == UIFont(name: "HelveticaNeue-Thin", size: 24) {
            timedButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 24)
            learnAsYouGoButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 24)
        } else {
//            timedButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 24)
        }
    }
    @IBAction func startQuizButtonHit(sender: AnyObject) {
        
    }
    
    @IBAction func unwindToQuizPicker(segue: UIStoryboardSegue) {
    }
}
