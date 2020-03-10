//
//  UIColor+Extension.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2020/03/09.
//  Copyright © 2020 TaeinKim. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    open class var T_MAJOR_BG: UIColor {
        get {
            return UIColor(hex: "#FAFAFA", alpha: 1.0)
        }
    }
    
    open class var MONO0: UIColor {
        get {
            return UIColor(hex: "#FFFFFF", alpha: 1.0)
        }
    }
    
    open class var MONO100: UIColor {
        get {
            return UIColor(hex: "#F5F5F5", alpha: 1.0)
        }
    }
    
    open class var MONO200: UIColor {
        get {
            return UIColor(hex: "#E3E3E3", alpha: 1.0)
        }
    }
    
    open class var MONO300: UIColor {
        get {
            return UIColor(hex: "#D0D0D0", alpha: 1.0)
        }
    }
    
    open class var MONO400: UIColor {
        get {
            return UIColor(hex: "#B1B1B1", alpha: 1.0)
        }
    }
    
    open class var MONO500: UIColor {
        get {
            return UIColor(hex: "#717171", alpha: 1.0)
        }
    }
    
    open class var MONO600: UIColor {
        get {
            return UIColor(hex: "#000000", alpha: 1.0)
        }
    }
    
    open class var SUB100: UIColor {
        get {
            return UIColor(hex: "#ECF8FC", alpha: 1.0)
        }
    }
    
    open class var SUB200: UIColor {
        get {
            return UIColor(hex: "#C5DBF1", alpha: 1.0)
        }
    }
    
    open class var MAIN100: UIColor {
        get {
            return UIColor(hex: "#02D6F0", alpha: 1.0)
        }
    }
    
    open class var MAIN200: UIColor {
        get {
            return UIColor(hex: "#01ADDD", alpha: 1.0)
        }
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
