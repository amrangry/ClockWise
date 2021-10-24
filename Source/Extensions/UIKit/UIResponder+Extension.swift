//
//  UIResponder+Extension.swift
//  Resturant
//
//  Created by Amr Elghadban on 3/23/19.
//  Copyright © 2019 ADKATech.com All rights reserved.
//
import UIKit

public extension  UIResponder {
    @objc static var reusableIdentifier: String {
        return String(describing: self)
    }
}
