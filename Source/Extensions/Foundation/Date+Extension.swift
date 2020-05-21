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

//  Created by AmrAngry on 3/1/20.
public extension Date {
    // credit to @eirnym, adapted this from their OBJC code: https://gist.github.com/eirnym/c9526a045556e4d8464b41a367843e3c
    // generates a random date and time in the past, limited by daysBack (a number of days before today)
    // also generates a random time to go with that date.
    // original request: http://stackoverflow.com/questions/10092468/how-do-you-generate-a-random-date-in-objective-c
    
    static func random(daysBack: Int) -> Date? {
        let day = arc4random_uniform(UInt32(daysBack))+1
        let hour = arc4random_uniform(23)
        let minute = arc4random_uniform(59)
        
        let today = Date(timeIntervalSinceNow: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = -1 * Int(day - 1)
        offsetComponents.hour = -1 * Int(hour)
        offsetComponents.minute = -1 * Int(minute)
        
        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
        return randomDate
    }
}

public extension Date {
    
    func toString(using format: String? = "E d MMM yyyy") -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current // TimeZone(abbreviation: "UTC")
        return formatter.string(from: self)
    }
    
    func displayString() -> String {
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        //        let date = dateFormatter.date(from: self.string)
        //        dateFormatter.dateFormat = "yyyy-MM-dd"
        //        return  dateFormatter.string(from: date!)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.current // TimeZone(abbreviation: "UTC")
        return formatter.string(from: self)
        
    }
    
    var day: Double {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        return Double(calendar.component(.day, from: self))
    }
    
    var dayString: String {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        return "\(calendar.component(.day, from: self))"
    }
    
    var month: Double {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        return Double(calendar.component(.month, from: self))
    }
    
    var monthString: String {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        return "\(calendar.component(.month, from: self))"
    }
    
    var year: Double {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        return Double(calendar.component(.year, from: self))
    }
    
    var yearString: String {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        return "\(calendar.component(.year, from: self))"
    }
    
    var firstDayOfMonth: Date {
        var dateComponent = DateComponents()
        dateComponent.day = 1
        dateComponent.hour = 0
        dateComponent.minute = 0
        dateComponent.second = 0
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let currentDate = self
        dateComponent.month = Int(currentDate.month)
        dateComponent.year = Int(currentDate.year)
        return calendar.date(from: dateComponent)!
    }
    
    var firstDayOfYear: Date {
        var dateComponent = DateComponents()
        dateComponent.day = 1
        dateComponent.hour = 0
        dateComponent.minute = 0
        dateComponent.second = 0
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let currentDate = self
        dateComponent.month = 1
        dateComponent.year = Int(currentDate.year)
        return calendar.date(from: dateComponent)!
    }
    
    var lastDayOfYear: Date {
        var dateComponent = DateComponents()
        dateComponent.day = 31
        dateComponent.hour = 23
        dateComponent.minute = 59
        dateComponent.second = 59
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let currentDate = self
        dateComponent.month = 12
        dateComponent.year = Int(currentDate.year)
        return calendar.date(from: dateComponent)!
    }
    
    var today: Date {
        var dateComponent = DateComponents()
        dateComponent.hour = 0
        dateComponent.minute = 0
        dateComponent.second = 0
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let currentDate = self
        dateComponent.day = Int(currentDate.day)
        dateComponent.month =  Int(currentDate.month)
        dateComponent.year = Int(currentDate.year)
        return calendar.date(from: dateComponent)!
    }
    
    var lastDayOfMonth: Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let currentDate = self
        let numberOfDays = calendar.range(of: .day, in: .month, for: currentDate)
        var dateComponent = DateComponents()
        dateComponent.day = (numberOfDays?.upperBound)!-1
        dateComponent.month = Int(currentDate.month)
        dateComponent.year = Int(currentDate.year)
        dateComponent.hour = 0
        dateComponent.minute = 0
        dateComponent.second = 0
        return calendar.date(from: dateComponent)!
    }
    
    var nextDay: Date {
        var dateComponent = DateComponents()
        dateComponent.day = 1
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        return calendar.date(byAdding: dateComponent, to: self) ?? self
    }
    
    var nextMonth: Date {
        var dateComponent = DateComponents()
        dateComponent.month = 1
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        return calendar.date(byAdding: dateComponent, to: self) ?? self
    }
    
    var previousDay: Date {
        var dateComponent = DateComponents()
        dateComponent.day = -1
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        return calendar.date(byAdding: dateComponent, to: self) ?? self
    }
    
    var previousMonth: Date {
        var dateComponent = DateComponents()
        dateComponent.month = -1
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        return calendar.date(byAdding: dateComponent, to: self) ?? self
    }
    
    var nextYear: Date {
        var dateComponent = DateComponents()
        dateComponent.year = 1
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        return calendar.date(byAdding: dateComponent, to: self) ?? self
    }
    
    var previousYear: Date {
        var dateComponent = DateComponents()
        dateComponent.year = -1
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        return calendar.date(byAdding: dateComponent, to: self) ?? self
    }
    
    var dayOfYear: Double {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let day = calendar.ordinality(of: .day, in: .year, for: self)
        return Double(day ?? 1)
    }
}
