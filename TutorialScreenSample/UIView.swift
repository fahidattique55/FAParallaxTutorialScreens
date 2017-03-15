//
//  UIView.swift
//  TutorialScreenSample
//
//  Created by Fahid Attique on 15/04/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import Foundation
import UIKit



// UIView Designables Extension -> IBInspectable does not show changes incase of native IOS views. so by creating extension we can get these functions in its subclasses where we can see changes via subclasses.


@IBDesignable public extension UIView{
    
    
    @IBInspectable var cornerRadius:CGFloat{
        
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    
    @IBInspectable var borderWidth:CGFloat{
        
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    
    @IBInspectable var borderColor:UIColor{
        
        set {
            layer.borderColor = newValue.cgColor
        }
        get {
            return UIColor.init(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
    }
    
    
    @IBInspectable var roundSides:Bool{
        
        set {
            if newValue {
                self.cornerRadius = self.frame.size.height / 2
            }
            else{
                self.cornerRadius = 0.0
            }
        }
        get {
            if self.cornerRadius == self.frame.size.height / 2 {
                return true
            }
            else{
                return false
            }
        }
    }
    
}

