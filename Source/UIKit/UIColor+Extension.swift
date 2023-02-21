//
//  UIColor+Extension.swift
//  Awoon
//
//  Created by Amr Elghadban on 12/28/17.
//  Copyright © 2017 AdKa  Inc. All rights reserved.
//

import Foundation
import UIKit

public enum UIColorInputError: Error {
    case missingHashMarkAsPrefix,
        unableToScanHexValue,
        mismatchedHexStringLength
}

public extension UIColor {

    // MARK: Creates a color from an hex int.
    
    convenience init(hex: UInt32) {
        let mask = 0x000000FF
        
        let rValue = Int(hex >> 16) & mask
        let gValue = Int(hex >> 8) & mask
        let bValue = Int(hex) & mask
        
        let red = CGFloat(rValue) / 255
        let green = CGFloat(gValue) / 255
        let blue = CGFloat(bValue) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: String) {
        var hexString = hex
        hexString = hexString.replacingOccurrences(of: "#", with: "", options: NSString.CompareOptions.literal, range: nil)
        let scanner = Scanner(string: hexString)
        //scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let rValue = (rgbValue & 0xFF0000) >> 16
        let gValue = (rgbValue & 0xFF00) >> 8
        let bValue = rgbValue & 0xFF
        
        self.init(
            red: CGFloat(rValue) / 0xFF,
            green: CGFloat(gValue) / 0xFF,
            blue: CGFloat(bValue) / 0xFF, alpha: 1
        )
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    /**
     The shorthand three-digit hexadecimal representation of color.
     #RGB defines to the color #RRGGBB.
     
     - parameter hex3: Three-digit hexadecimal value.
     - parameter alpha: 0.0 - 1.0. The default is 1.0.
     */
    convenience init(hex3: UInt16, alpha: CGFloat = 1) {
        let divisor = CGFloat(15)
        let red = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let green = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let blue = CGFloat(hex3 & 0x00F) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The shorthand four-digit hexadecimal representation of color with alpha.
     #RGBA defines to the color #RRGGBBAA.
     
     - parameter hex4: Four-digit hexadecimal value.
     */
    convenience init(hex4: UInt16) {
        let divisor = CGFloat(15)
        let red = CGFloat((hex4 & 0xF000) >> 12) / divisor
        let green = CGFloat((hex4 & 0x0F00) >> 8) / divisor
        let blue = CGFloat((hex4 & 0x00F0) >> 4) / divisor
        let alpha = CGFloat(hex4 & 0x000F) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The six-digit hexadecimal representation of color of the form #RRGGBB.
     
     - parameter hex6: Six-digit hexadecimal value.
     */
    convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green = CGFloat((hex6 & 0x00FF00) >> 8) / divisor
        let blue = CGFloat(hex6 & 0x0000FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The six-digit hexadecimal representation of color with alpha of the form #RRGGBBAA.
     
     - parameter hex8: Eight-digit hexadecimal value.
     */
    convenience init(hex8: UInt32) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let green = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let blue = CGFloat((hex8 & 0x0000FF00) >> 8) / divisor
        let alpha = CGFloat(hex8 & 0x000000FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, throws error.
     
     - parameter rgba: String value.
     */
    convenience init(rgba_throws rgba: String) throws {
        guard rgba.hasPrefix("#") else {
            throw UIColorInputError.missingHashMarkAsPrefix
        }
    
        let index =  rgba.index(rgba.startIndex, offsetBy: 1)//String.Index
        let hexStringSequance = rgba[index...]
        let hexString = String(hexStringSequance)
        //let hexString: String = rgba.substring(from: index) //deprecated
        var hexValue: UInt32 = 0
        
        guard Scanner(string: hexString).scanHexInt32(&hexValue) else {
            throw UIColorInputError.unableToScanHexValue
        }
        
        switch hexString.count {
        case 3:
            self.init(hex3: UInt16(hexValue))
        case 4:
            self.init(hex4: UInt16(hexValue))
        case 6:
            self.init(hex6: hexValue)
        case 8:
            self.init(hex8: hexValue)
        default:
            throw UIColorInputError.mismatchedHexStringLength
        }
    }
    
    /**
     The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, fails to default color.
     
     - parameter rgba: String value.
     */
    convenience init(_ rgba: String, defaultColor: UIColor = UIColor.clear) {
        guard let color = try? UIColor(rgba_throws: rgba) else {
            self.init(cgColor: defaultColor.cgColor)
            return
        }
        self.init(cgColor: color.cgColor)
    }
    
    /**
     Hex string of a UIColor instance.
     
     - parameter includeAlpha: Whether the alpha should be included.
     */
    func hexString(_ includeAlpha: Bool = true) -> String {
        var rValue: CGFloat = 0
        var gValue: CGFloat = 0
        var bValue: CGFloat = 0
        var aValue: CGFloat = 0
        self.getRed(&rValue, green: &gValue, blue: &bValue, alpha: &aValue)
        
        if includeAlpha {
            return String(format: "#%02X%02X%02X%02X", Int(rValue * 255), Int(gValue * 255), Int(bValue * 255), Int(aValue * 255))
        } else {
            return String(format: "#%02X%02X%02X", Int(rValue * 255), Int(gValue * 255), Int(bValue * 255))
        }
    }
}
