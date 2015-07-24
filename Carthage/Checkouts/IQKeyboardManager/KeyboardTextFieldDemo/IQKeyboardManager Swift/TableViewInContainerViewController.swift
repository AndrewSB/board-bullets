//
//  TableViewInContainerViewController.swift
//  IQKeyboardManager
//
//  Created by InfoEnum02 on 20/04/15.
//  Copyright (c) 2015 Iftekhar. All rights reserved.
//

import UIKit

class TableViewInContainerViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "TestCell"
        
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? UITableViewCell
        
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
            cell?.backgroundColor = UIColor.clearColor()
            
            let contentView : UIView! = cell?.contentView
            
            let textField = UITextField(frame: CGRectMake(10,0,contentView.frame.size.width-20,33))
            textField.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
            textField.center = contentView.center;
            textField.backgroundColor = UIColor.clearColor()
            textField.borderStyle = UITextBorderStyle.RoundedRect
            textField.tag = 123
            cell?.contentView.addSubview(textField)
        }

        let textField : UITextField = cell!.viewWithTag(123) as! UITextField;
        textField.placeholder = "Cell \(indexPath.row)"
        
        return cell!
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
}
