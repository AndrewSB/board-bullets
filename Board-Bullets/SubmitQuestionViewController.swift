//
//  SubmitQuestionViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/25/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class SubmitQuestionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let categories = ["Behavioral Science", "Biochemistry", "Embryology", "Microbiology", "Immunology", "Pathology", "Pharmacology"]
    
    let subcategories = ["Cardiovascular", "Endocrine", "Gastrointestinal", "Hematology", "Oncology", "Anatomical Pathology", "Neurology", "Psychiatry", "Nephrology", "Respiratory", "Reproductive", "Other"]
    
    var cat = false
    var category: String = ""
    var subcategory: String = ""
    
    @IBOutlet weak var questionLabel: CircularEdgeTextField!
    @IBOutlet weak var answerLabel: CircularEdgeTextField!
    @IBOutlet weak var dummyAnswerLabel: CircularEdgeTextField!
    @IBOutlet weak var dummyAnswerLabel2: CircularEdgeTextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var subcategoryButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)

    let pickerController = UIPickerView()
    let pickerControllerView = UIView()
    
    
    override func viewDidLoad() {
        addTextDismiss()
        super.viewDidLoad()
        activityIndicator.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2)
        
        category = categories[0]
        subcategory = subcategories[0]
        
        
        pickerController.frame = CGRectMake(22, 0, self.view.bounds.width - 44, 100)
        pickerControllerView.frame = CGRectMake(0, self.view.bounds.height - 100, self.view.bounds.width, 100)
        pickerControllerView.addSubview(pickerController)
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return cat ? categories.count : subcategories.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
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
            question["category"] = category
            question["subcategory"] = subcategory
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

}
