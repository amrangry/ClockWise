//
//  Date+Extension.swift
//  MotoShop
//
//  Created by AmrAngry on 4/21/20.
//  Copyright © 2020 ADKA Tech. All rights reserved.
//

import Foundation

public extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}
