//
//  UITextField + LeftPadded.swift
//  CCAvenue Mars
//
//  Created by Ram Mhapasekar on 7/14/17.
//  Copyright © 2017 CCAvenue. All rights reserved.
//

import UIKit

class LeftPaddedTextField: UITextFieldX {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10 , y: bounds.origin.y, width: bounds.width-10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10 , y: bounds.origin.y, width: bounds.width-10, height: bounds.height)
    }
}
