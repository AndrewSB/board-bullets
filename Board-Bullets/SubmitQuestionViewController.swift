//
//  SubmitQuestionViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/25/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class SubmitQuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let categories = ["Behavioral Science", "Biochemistry", "Embryology", "Microbiology", "Immunology", "Pathology", "Pharmacology"]
    
    let subcategories = ["Cardiovascular", "Endocrine", "Gastrointestinal", "Hematology", "Oncology", "Anatomical Pathology", "Neurology", "Psychiatry", "Nephrology", "Respiratory", "Reproductive", "Other"]
    
    var cat = false
    var categoryIndex = 0
    var subcategoryIndex = 0
    
    @IBOutlet weak var questionLabel: CircularEdgeTextField!
    @IBOutlet weak var answerLabel: CircularEdgeTextField!
    @IBOutlet weak var dummyAnswerLabel: CircularEdgeTextField!
    @IBOutlet weak var dummyAnswerLabel2: CircularEdgeTextField!

    @IBOutlet weak var categoryTableView: UITableView!
    
    
    @IBOutlet weak var backButton: UIButton!
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    
    
    override func viewDidLoad() {
//        addTextDismiss()
        super.viewDidLoad()
        activityIndicator.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2)
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID") as! UITableViewCell
        
//        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Category: \(categories[categoryIndex])"
        } else {
            cell.textLabel?.text = "Subcategory: \(subcategories[subcategoryIndex])"
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
    }


    
    @IBAction func submitButtonWasHit(sender: AnyObject) {
        let alert = UIAlertController(title: "Uh oh", message: "", preferredStyle: .Alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(okButton)
        
        if questionLabel.text == "" {
            alert.message = "Please enter a question"
            self.presentViewController(alert, animated: true, completion: nil)
        } else if answerLabel.text == "" {
            alert.message = "Please enter an answer"
            self.presentViewController(alert, animated: true, completion: nil)
        } else if dummyAnswerLabel.text == "" {
            alert.message = "Please enter the first dummy question"
            self.presentViewController(alert, animated: true, completion: nil)
        } else if dummyAnswerLabel2.text == "" {
            alert.message = "Please enter the second dummy question"
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            let question = PFObject(className: "UserQuestions")
            question["category"] = categories[categoryIndex]
            question["subcategory"] = subcategories[subcategoryIndex]
            question["question"] = questionLabel.text.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
            question["option1"] = dummyAnswerLabel.text.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
            question["option2"] = dummyAnswerLabel2.text.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
            question["option3"] = answerLabel.text.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
            
            view.addSubview(activityIndicator)
            question.saveInBackgroundWithBlock({(PFBooleanResultBlock) in
                alert.title = "Added question"
                alert.message = "Your questions have been added for review. Check back in a couple hours to see if it's been added!"
                
                self.activityIndicator.removeFromSuperview()
            
                self.presentViewController(alert, animated: true, completion: nil)
            })
        }
    
    }

    @IBAction func categoryButtonWasHit(sender: AnyObject) {
        cat = true
    }
    
    @IBAction func subcategoryButtonWasHit(sender: AnyObject) {
        cat = false
    }

    @IBAction func backButtonWasHit(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if let des = segue.destinationViewController as? SubmitQuestionPickerViewController {
            des.title = cat ? "Category" : "Subcategory"
            des.data = cat ? categories : subcategories
            des.cat = cat
        }
    }
}
