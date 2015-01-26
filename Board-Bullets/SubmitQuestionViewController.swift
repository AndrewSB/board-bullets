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

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func submitButtonWasHit(sender: AnyObject) {
    }
}
