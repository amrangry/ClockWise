//
//  DateFormatter+Extension.swift
//  onNet
//
//  Created by AmrAngry on 11/11/19.
//  Copyright © 2019 ADKATech.com. All rights reserved.
//

import Foundation

public extension DateFormatter {
    static var shared: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "E MMM dd HH:mm:SS ZZZZ yyyy"
        return formatter
    }
}
