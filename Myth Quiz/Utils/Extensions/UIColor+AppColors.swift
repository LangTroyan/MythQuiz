//
//  UIColor+Colors.swift
//  Myth Quiz
//
//  Created by Trujillo Baez, Dylan Alfonso (ES - Barcelona) on 05/09/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//

import UIKit

extension UIColor{
    open class var appOrange : UIColor {
        get {
            return UIColor(red: 238.0/255, green: 155.0/255, blue: 77.0/255, alpha: 1.0)
        }
    }
    
    open class var appOrangeTransparent : UIColor {
        get {
            return UIColor(red: 238.0/255, green: 155.0/255, blue: 77.0/255, alpha: 0.25)
        }
    }
    
    open class var appBlue : UIColor {
        get {
            return UIColor(red: 52.0/255, green: 120.0/255, blue: 246.0/255, alpha: 1.0)
        }
    }
    
    open class var appBlueTransparent : UIColor {
        get {
            return UIColor(red: 52.0/255, green: 120.0/255, blue: 246.0/255, alpha: 0.25)
        }
    }
    
    open class var appRed : UIColor {
        get {
            return UIColor(red: 195.0/255, green: 48.0/255, blue: 36.0/255, alpha: 1.0)
        }
    }
    
    open class var appRedTransparent : UIColor {
        get {
            return UIColor(red: 195.0/255, green: 48.0/255, blue: 36.0/255, alpha: 0.25)
        }
    }
}
