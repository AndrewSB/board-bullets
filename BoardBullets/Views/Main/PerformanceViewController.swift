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

        let c = PFUser.currentUser()!["correct"] as? Int
        let n = PFUser.currentUser()!["answered"] as? Int
        
        if (c != nil) {
            
            let percentage = Float(c!)/Float(n!) * 100
            
            percentageLabel.text = "\(percentage)% correct"
            correctLabel.text = "\(c!) answered correctly"
            numQuestionsLabel.text = "\(n!) answered"
            
        } else {
            percentageLabel.text = "100% correct"
            correctLabel.text = "0 questions answered correctly"
            numQuestionsLabel.text = "0 questions answered"
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
