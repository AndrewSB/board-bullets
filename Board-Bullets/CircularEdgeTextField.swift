//
//  CircularEdgeTextField.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/10/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class CircularEdgeTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 2
        layer.cornerRadius = 13
        clipsToBounds = true
        
        layer.sublayerTransform = CATransform3DMakeTranslation(3, 0, 0)
    }
}
