//
//  SubmitQuestionPickerViewController.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 3/27/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class SubmitQuestionPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var data: [String]?
    var cat: Bool?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = self.title
        
        picker.delegate = self
        picker.dataSource = self
    }

    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data!.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return data![row]
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if let des = segue.destinationViewController as? SubmitQuestionViewController {
            
            if cat! {
                des.categoryIndex = picker.selectedRowInComponent(0)
            } else {
                des.subcategoryIndex = picker.selectedRowInComponent(0)
            }
            
            println("indices \(des.categoryIndex) \(des.subcategoryIndex)")
        }
    }
}
