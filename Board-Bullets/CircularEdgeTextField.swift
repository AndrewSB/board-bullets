//
//  CircularEdgeTextField.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/10/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import Foundation

class CircularEdgeTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 2
        let color = UIColor(red: 0.104, green: 0.457, blue: 0.734, alpha: 1)
        self.layer.borderColor = color.CGColor

        clipsToBounds = true
        
        layer.sublayerTransform = CATransform3DMakeTranslation(3, 0, 0)
    }
}
