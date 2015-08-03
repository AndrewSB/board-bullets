//
//  PerformanceViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 3/3/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import Parse

class PerformanceViewController: UIViewController {
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var numQuestionsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let (c, n) = UserDefaults.performance
        println("performance is \(UserDefaults.performance)")
        
        var percentage: Float
        if n != 0 {
            percentage = Float(c)/Float(n) * 100
        } else {
            percentage = 100
        }
        
        percentageLabel.text = "\(percentage)% correct"
        correctLabel.text = "\(c) answered correctly"
        numQuestionsLabel.text = "\(n) answered"
        
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
