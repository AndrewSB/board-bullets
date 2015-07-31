//
//  QuizAnswerViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/27/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class QuizAnswerViewController: UIViewController {
    var question: Question!

    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var option1Label: UILabel!
    @IBOutlet weak var option2Label: UILabel!
    @IBOutlet weak var option3Label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = question.question
        option1Label.text = question.optionOne
        option2Label.text = question.optionTwo
        option3Label.text = question.optionThree
        
        configureSwipeGestures()

        
        let dict = [option1Label, option2Label, option3Label]
        
        // red
        dict[question.chosen - 1].textColor = UIColor(red: 0.953, green: 0.129, blue: 0.047, alpha: 1)
        // green
        dict[question.answer - 1].font = UIFont(name: "HelveticaNeue-Bold", size: 22)
        dict[question.answer - 1].textColor = UIColor(red: 0.157, green: 0.753, blue: 0.482, alpha: 1)
        
        for item in dict {
            if item != dict[question.answer - 1] {
                item.font = UIFont(name: "HelveticaNeue-Thin", size: 20)
            }
        }
    }
    
    
    func configureSwipeGestures() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: Selector("downSwiped"))
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    func downSwiped() {
        unwindClicked(self)
    }
    
    @IBAction func unwindClicked(sender: AnyObject) {}

}
