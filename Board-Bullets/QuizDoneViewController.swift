//
//  QuizDoneViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/15/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class QuizDoneViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    var answers = [Bool]()

    override func viewDidLoad() {
        super.viewDidLoad()
        var curY = 22
        for (index, element) in enumerate(answers) {
            let label = UILabel(frame: CGRectMake(22, CGFloat(curY), 100, 22))
            label.text = "Question \(index+1)"
            label.textColor = element ? UIColor.greenColor() : UIColor.redColor()
            
            curY += 22
            
            view.addSubview(label)
        }
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
