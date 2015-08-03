//
//  QuizDoneViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/15/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import Foundation
import Parse

class QuizDoneViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var questions = [Question]()
    var answerIndex = Int()
    
    @IBOutlet weak var rightOutOfQuestionsLabel: UILabel!
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var numberCorrect = 0
        for question in questions {
            if question.answer == question.chosen {
                numberCorrect++
            }
        }
        
        UserDefaults.performance.answered += questions.count
        UserDefaults.performance.correct += numberCorrect
        
        rightOutOfQuestionsLabel.text = "\(numberCorrect)/\(questions.count)"
        
        configurePerformaceDict(numberCorrect)
        println("made it out, performance is \(UserDefaults.performance)")
    }
    
    // Isn't really used rn. Switched to a local model
    func configurePerformaceDict(numCorrect: Int) {
        var a = PFUser.currentUser()!["answered"] as? Int
        var b: Int = a == nil ? questions.count : a! + questions.count
        PFUser.currentUser()!["answered"] = b as AnyObject?
        
        a = PFUser.currentUser()!["correct"] as! Int?
        b = a == nil ? numCorrect : a! + numCorrect
        PFUser.currentUser()!["correct"] = b
    }
    
    
    // ======================================
    // COLLECTION VIEW METHODS
    // ======================================
    func collectionView(colorCollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    func collectionView(colorCollectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = resultsCollectionView.dequeueReusableCellWithReuseIdentifier("result", forIndexPath: indexPath) as! resultViewCell
        
        let questionItem = questions[indexPath.item]
        
        cell.textLabel.text = questionItem.question
        cell.layer.backgroundColor = UIColor.whiteColor().CGColor

        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 2
        
        if questionItem.answer != questionItem.chosen {
            cell.layer.borderColor = UIColor(red: 0.953, green: 0.129, blue: 0.047, alpha: 1).CGColor
        } else {
            cell.layer.borderColor = UIColor.blackColor().CGColor
        }
        return cell
    }
    
    func collectionView(colorCollectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = resultsCollectionView.frame.width
        let height = resultsCollectionView.frame.height
        
        return CGSize(width: width/2 - 5, height: width/2 - 5)
        
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        answerIndex = indexPath.row
        performSegueWithIdentifier("segueToAnswer", sender: self)
    }
    
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let d = segue.destinationViewController as? QuizAnswerViewController {
            d.question = questions[answerIndex]
        }
    }

    @IBAction func unwindToQuizDone(segue: UIStoryboardSegue) {}

}
