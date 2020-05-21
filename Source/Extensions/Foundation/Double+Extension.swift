//
//  Double+Extension.swift
//  Resturant
//
//  Created by AmrAngry on 9/21/19.
//  Copyright © 2019 adka. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func roundToDecimal(_ fractionDigits: Int) -> Double {
           let multiplier = pow(10, Double(fractionDigits))
           return Darwin.round(self * multiplier) / multiplier
       }
    
    /// Rounds the double to decimal places value
    func roundToString(withPlace: Int) -> String? {
        //print(String(format: "%.2f", self))
        let doubleValue = rounded(toPlaces: withPlace)
        let number = NSNumber(value: doubleValue)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        //        numberFormatter.numberStyle = .currency
        //        numberFormatter.usesGroupingSeparator = true
        //        numberFormatter.groupingSeparator = ","
        //        numberFormatter.groupingSize = 3
        //        numberFormatter.currencySymbol = ""
        //        numberFormatter.locale = NSLocale.current
        //        numberFormatter.negativeFormat = "-#,##0.##"
        //        numberFormatter.maximumFractionDigits = withPlace
        numberFormatter.minimumFractionDigits = withPlace
        
        //let numberFrom = numberFormatter.number(from: "99.91")
        let roundedString = numberFormatter.string(from: number)
        return roundedString
    }
}

/*
With Swift 5, according to your needs, you can choose one of the 9 following styles in order to have a rounded result from a Double.

#1. Using FloatingPoint rounded() method
In the simplest case, you may use the Double round() method.

let roundedValue1 = (0.6844 * 1000).rounded() / 1000
let roundedValue2 = (0.6849 * 1000).rounded() / 1000
print(roundedValue1) // returns 0.684
print(roundedValue2) // returns 0.685
#2. Using FloatingPoint rounded(_:) method
let roundedValue1 = (0.6844 * 1000).rounded(.toNearestOrEven) / 1000
let roundedValue2 = (0.6849 * 1000).rounded(.toNearestOrEven) / 1000
print(roundedValue1) // returns 0.684
print(roundedValue2) // returns 0.685
#3. Using Darwin round function
Foundation offers a round function via Darwin.

import Foundation

let roundedValue1 = round(0.6844 * 1000) / 1000
let roundedValue2 = round(0.6849 * 1000) / 1000
print(roundedValue1) // returns 0.684
print(roundedValue2) // returns 0.685
#4. Using a Double extension custom method built with Darwin round and pow functions
If you want to repeat the previous operation many times, refactoring your code can be a good idea.

import Foundation

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}

let roundedValue1 = 0.6844.roundToDecimal(3)
let roundedValue2 = 0.6849.roundToDecimal(3)
print(roundedValue1) // returns 0.684
print(roundedValue2) // returns 0.685
#5. Using NSDecimalNumber rounding(accordingToBehavior:) method
If needed, NSDecimalNumber offers a verbose but powerful solution for rounding decimal numbers.

import Foundation

let scale: Int16 = 3

let behavior = NSDecimalNumberHandler(roundingMode: .plain, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)

let roundedValue1 = NSDecimalNumber(value: 0.6844).rounding(accordingToBehavior: behavior)
let roundedValue2 = NSDecimalNumber(value: 0.6849).rounding(accordingToBehavior: behavior)

print(roundedValue1) // returns 0.684
print(roundedValue2) // returns 0.685
#6. Using NSDecimalRound(_:_:_:_:) function
import Foundation

let scale = 3

var value1 = Decimal(0.6844)
var value2 = Decimal(0.6849)

var roundedValue1 = Decimal()
var roundedValue2 = Decimal()

NSDecimalRound(&roundedValue1, &value1, scale, NSDecimalNumber.RoundingMode.plain)
NSDecimalRound(&roundedValue2, &value2, scale, NSDecimalNumber.RoundingMode.plain)

print(roundedValue1) // returns 0.684
print(roundedValue2) // returns 0.685
#7. Using NSString init(format:arguments:) initializer
If you want to return a NSString from your rounding operation, using NSString initializer is a simple but efficient solution.

import Foundation

let roundedValue1 = NSString(format: "%.3f", 0.6844)
let roundedValue2 = NSString(format: "%.3f", 0.6849)
print(roundedValue1) // prints 0.684
print(roundedValue2) // prints 0.685
#8. Using String init(format:_:) initializer
Swift’s String type is bridged with Foundation’s NSString class. Therefore, you can use the following code in order to return a String from your rounding operation:

import Foundation

let roundedValue1 = String(format: "%.3f", 0.6844)
let roundedValue2 = String(format: "%.3f", 0.6849)
print(roundedValue1) // prints 0.684
print(roundedValue2) // prints 0.685
#9. Using NumberFormatter
If you expect to get a String? from your rounding operation, NumberFormatter offers a highly customizable solution.

import Foundation

let formatter = NumberFormatter()
formatter.numberStyle = NumberFormatter.Style.decimal
formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
formatter.maximumFractionDigits = 3

let roundedValue1 = formatter.string(from: 0.6844)
let roundedValue2 = formatter.string(from: 0.6849)
print(String(describing: roundedValue1)) // prints Optional("0.684")
print(String(describing: roundedValue2)) // prints Optional("0.685")
*/
