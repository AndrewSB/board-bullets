//
//  SubmitQuestionViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/25/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class SubmitQuestionViewController: UIViewController {
    @IBOutlet weak var questionLabel: CircularEdgeTextField!
    @IBOutlet weak var answerLabel: CircularEdgeTextField!
    @IBOutlet weak var dummyAnswerLabel: CircularEdgeTextField!
    @IBOutlet weak var dummyAnswerLabel2: CircularEdgeTextField!
    @IBOutlet weak var categoryLabel: CircularEdgeTextField!
    @IBOutlet weak var subcategoryLabel: CircularEdgeTextField!
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)

    override func viewDidLoad() {
        addTextDismiss()
        super.viewDidLoad()
        activityIndicator.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2)

    }
    @IBAction func submitButtonWasHit(sender: AnyObject) {
        let question = PFObject(className: "UserQuestions")
        question["category"] = categoryLabel.text.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
        question["subcategory"] = subcategoryLabel.text.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
        question["question"] = questionLabel.text.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
        question["option1"] = dummyAnswerLabel.text.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
        question["option2"] = dummyAnswerLabel2.text.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
        question["option3"] = answerLabel.text.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
        
        view.addSubview(activityIndicator)
        question.saveInBackgroundWithBlock({(PFBooleanResultBlock) in
            println("saved")
            self.activityIndicator.removeFromSuperview()
        })
    
    }
}
