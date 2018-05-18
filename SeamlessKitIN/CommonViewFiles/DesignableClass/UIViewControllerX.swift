//
//  UIViewControllerX.swift
//  CCAvenue Mars
//
//  Created by Ram Mhapasekar on 7/14/17.
//  Copyright © 2017 CCAvenue. All rights reserved.
//

import UIKit

@IBDesignable
class UIViewControllerX: UIViewController {
    
    @IBInspectable var lightStatusBar: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            if lightStatusBar {
                return UIStatusBarStyle.lightContent
            } else {
                return UIStatusBarStyle.default
            }
        }
    }
}
