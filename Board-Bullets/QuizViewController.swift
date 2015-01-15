//
//  QuizViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/14/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var option1Label: UIButton!
    @IBOutlet weak var option2Label: UIButton!
    @IBOutlet weak var option3Label: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func reviewButtonWasHit(sender: AnyObject) {
    }

    @IBAction func pauseButtonWasHit(sender: AnyObject) {
    }
}
