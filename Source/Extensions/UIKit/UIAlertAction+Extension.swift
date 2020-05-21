//
//  UIAlertAction+Extension.swift
//  Resturant
//
//  Created by AmrAngry on 3/26/20.
//  Copyright © 2020 adka. All rights reserved.
//

import UIKit
//KVC called titleTextColor. This KVC allows you to set exactly what you need, the color for the UIAlertAction text.
extension UIAlertAction {
    var titleTextColor: UIColor? {
        get {
            return self.value(forKey: "titleTextColor") as? UIColor
        } set {
            self.setValue(newValue, forKey: "titleTextColor")
        }
    }
}
