//
//  SubmitQuestionViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/25/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import Parse

class SubmitQuestionViewController: UIViewController {
    let categories = ["Behavioral Science", "Biochemistry", "Embryology", "Microbiology", "Immunology", "Pathology", "Pharmacology", "Other"]
    
    let subcategories = ["Cardiovascular", "Endocrine", "Gastrointestinal", "Hematology", "Oncology", "Anatomical Pathology", "Neurology", "Psychiatry", "Nephrology", "Respiratory", "Reproductive", "Other"]
    
    var cat = false
    var categoryIndex = 0 {
        didSet {
            categoryTableView.reloadData()
        }
    }
    var subcategoryIndex = 0 {
        didSet {
            categoryTableView.reloadData()
        }
    }
    
    @IBOutlet weak var questionLabel: CircularEdgeTextField!
    @IBOutlet weak var answerLabel: CircularEdgeTextField!
    @IBOutlet weak var dummyAnswerLabel: CircularEdgeTextField!
    @IBOutlet weak var dummyAnswerLabel2: CircularEdgeTextField!

    @IBOutlet weak var categoryTableView: UITableView!
    
    
    @IBOutlet weak var backButton: UIButton!
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTextDismiss()
        activityIndicator.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2)
        
        [questionLabel, answerLabel, dummyAnswerLabel, dummyAnswerLabel2].forEach {
                $0.delegate = self
        }
        
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
    }
    
    override func addTextDismiss() {
        let gestureRecog = UITapGestureRecognizer(target: self, action: "hideKeyboard:")
        self.view.addGestureRecognizer(gestureRecog)
        gestureRecog.cancelsTouchesInView = false
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
            let question = PFObject(className: "Questions")
            question["field"] = categories[categoryIndex]
            question["subfield"] = subcategories[subcategoryIndex]
            question["question"] = questionLabel.text!.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
            question["optionOne"] = dummyAnswerLabel.text!.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
            question["optionTwo"] = dummyAnswerLabel2.text!.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
            question["optionThree"] = answerLabel.text!.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
            question["answer"] = answerLabel.text!.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
            question["approved"] = false
            
            
            view.addSubview(activityIndicator)
            question.saveInBackgroundWithBlock({(PFBooleanResultBlock) in
                alert.title = "Added question"
                alert.message = "Your question has been added for review. You should see it in the question bank within the next couple hours"
                
                self.activityIndicator.removeFromSuperview()
            
                self.presentViewController(alert, animated: true, completion: {
                    self.performSegueWithIdentifier("unwindToMain", sender: self)
                })
            })
        }
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if let des = segue.destinationViewController as? SubmitQuestionPickerViewController {
            
            des.title = cat ? "Category" : "Subcategory"
            des.data = cat ? categories : subcategories
            des.cat = cat
        }
    }
    
    @IBAction func unwindToSubmitScreen(segue: UIStoryboardSegue) {}
}

extension SubmitQuestionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID")!
        if indexPath.row == 0 {
            cell.textLabel?.text = "\(categories[categoryIndex])"
        } else {
            cell.textLabel?.text = "\(subcategories[subcategoryIndex])"
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.cat = indexPath.row == 0
        performSegueWithIdentifier("segueToPicker", sender: self)
    }

}

extension SubmitQuestionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case questionLabel:
            questionLabel.resignFirstResponder()
            answerLabel.becomeFirstResponder()
        case answerLabel:
            answerLabel.resignFirstResponder()
            dummyAnswerLabel.becomeFirstResponder()
        case dummyAnswerLabel:
            dummyAnswerLabel.resignFirstResponder()
            dummyAnswerLabel2.becomeFirstResponder()
        case dummyAnswerLabel2:
            dummyAnswerLabel2.resignFirstResponder()
            categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .None)
        default:()
        }
        
        return true
    }
}