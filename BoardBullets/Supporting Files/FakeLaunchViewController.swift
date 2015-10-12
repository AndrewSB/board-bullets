//
//  FakeLaunchViewController.swift
//  BoardBullets
//
//  Created by Andrew Breckenridge on 10/11/15.
//  Copyright © 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class FakeLaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = UINib(nibName: "LaunchScreen", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        v.frame.size = view.frame.size


        self.view.addSubview(v)
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

}
