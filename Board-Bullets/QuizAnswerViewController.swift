//
//  QuizAnswerViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/27/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class QuizAnswerViewController: UIViewController {
    var question = Question()

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
        
        let dict = [option1Label, option2Label, option3Label]
        
        dict[question.chosen - 1].textColor = UIColor.redColor()
        dict[question.answer - 1].textColor = UIColor.greenColor()    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
