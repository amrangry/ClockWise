//
//  String+Extension.swift
//  MotoShop
//
//  Created by AmrAngry on 1/4/20.
//  Copyright © 2020 ADKA Tech. All rights reserved.
//
import Foundation
import UIKit

public extension String {
    
    func trim() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func trimEmpty() -> String? {
        if self.isEmpty {
            return nil
        } else {
            return trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    func contains(_ find: String) -> Bool {
        return range(of: find) != nil
    }
    
    func containsIgnoringCase(_ find: String) -> Bool {
        return range(of: find, options: .caseInsensitive) != nil
    }
    
    func removeBlankSpaces(name: String) -> String {
        let trimmed = name.trimmingCharacters(in: .whitespaces)
        return trimmed
    }
    
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func wipeCharacters(characters: String) -> String {
        return replaceCharacters(characters: characters, toSeparator: "")
    }
    
    func replaceCharacters(characters: String, toSeparator: String) -> String {
        let characterSet = CharacterSet(charactersIn: characters)
        let components = self.components(separatedBy: characterSet)
        // self.componentsSeparatedByCharactersInSet(characterSet)
        let result = components.joined(separator: toSeparator)
        // components.joinWithSeparator("")
        return result
    }
    
    func replace(targetString: String, withString: String) -> String {
        // replace white spaces
        // way 1
        let newStringTest = replacingOccurrences(of: targetString, with: withString, options: .literal, range: nil)
        print(newStringTest)
        // way 2
        let toArray = components(separatedBy: targetString)
        let newString = toArray.joined(separator: withString)
        print(newString)
        return newString
    }
    
    func convertToURL() -> URL? {
        guard let urlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        let url = URL(string: urlString)
        return url
    }
    
    // MARK: - validation
    
    func isValidPhoneNumber() -> Bool {
        let regex = "^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = phoneTest.evaluate(with: self)
        return result
    }
    
    func isValidNumber() -> Bool {
        let phoneNumberRegex = "^[0-9]"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
    }
    
    func isValidNationalID() -> Bool {
        let regex = "^[0-9]{14}$" //"^[0-9]\\d{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = phoneTest.evaluate(with: self)
        return result
    }
    
    /// A Boolean value indicating whether a string is a valid email or not.
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
    
    func isValidPassword() -> Bool {
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        //let passwordRegEx = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        // let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        //return passwordTest.evaluate(with: self)
        if self.count >= 1 {
            return true
        }
        return false
    }
    
    func isValidToOpen() -> Bool {
        let urlString = self
        // Check for nil
        // guard let urlString = stringToBeChaecked  else {return false}
        // create NSURL instance
        guard let url = NSURL(string: urlString) as URL? else { return false }
        // check if your application can open the NSURL instance
        return UIApplication.shared.canOpenURL(url)
    }
    
    func isValid(urlString: String) -> Bool {
        if let urlComponents = URLComponents(string: urlString), urlComponents.host != nil, urlComponents.url != nil {
            return true
        }
        return false
    }
    
    func isValidURL() -> Bool {
        let urlString = self
        guard let url = NSURL(string: urlString) else { return false }
        if !UIApplication.shared.canOpenURL(url as URL) { return false }
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        // let urlPattern = "^(http|https|ftp)\\://([a-zA-Z0-9\\.\\-]+(\\:[a-zA-Z0-9\\.&amp;%\\$\\-]+)*@)*((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|localhost|([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9\\-]+\\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(\\:[0-9]+)*(/($|[a-zA-Z0-9\\.\\,\\?\\'\\\\\\+&amp;%\\$#\\=~_\\-]+))*$"
        //swiftlint:disable:previous line_length
        let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regEx])
        return predicate.evaluate(with: urlString)
    }
    
}

// MARK: - Localization

public extension String {
    
    var localized: String {
        let langKey = LanguageHandler.shared.getCurrentLanguageCode()
        var bundle: Bundle?
        if let localizationFilePath = Bundle.main.path(forResource: langKey, ofType: "lproj"), let localizedBundle = Bundle(path: localizationFilePath) {
            bundle = localizedBundle
        }
        let value = localized(bundle: bundle ?? .main)//NSLocalizedString(self, tableName: "Localizable", bundle: bundle, value: self, comment: "")
        return value
    }
    
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        //return NSLocalizedString(self, comment: "")
        let value = NSLocalizedString(self, tableName: tableName, bundle: .main, value: self, comment: "")
        return value
    }
}

// MARK: - static  methods

public extension String {
    static func stringToDate(_ str: String, formatterString: String?) -> Date? {
        let formatter = DateFormatter()
        var format = formatterString ?? ""
        if format.isEmpty {
            format = "yyyy-MM-dd hh:mm:ss Z"
        }
        formatter.dateFormat = format
        
        return formatter.date(from: str)
    }
    
    func toDate(formatterString: String? = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = DateFormatter()
        var format = formatterString ?? ""
        if format.isEmpty {
            format = "yyyy-MM-dd hh:mm:ss Z"
        }
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    func toString(using format: String? = "E d MMM yyyy") -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        
        guard let date = dateFormatterGet.date(from: self) else {
            return nil
        }
        let result = dateFormatterPrint.string(from: date)
        return result
    }
    
}

public extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
}

public extension String {
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    func isHtmlString() -> Bool {
        return contains("</div>") || contains("</font>") || contains("</html>") || contains("</strong>") || contains("<img")
    }
    
}

//Personal Name Splitter
public extension String {
    /// let name =  "Mr. Steven Paul Jobs Jr."
    /// personNameComponents requires iOS (10.0 and later)
    @available(iOS 10.0, *)
    func splitName() -> (String, String) {
        let name = self
        var firstName = name
        var lastName = ""
        
        // /* Way 1 */
        //        let nameArray = name.components(separatedBy: " ")
        //        if !nameArray.isEmpty, nameArray.count > 1 {
        //            for namePart in nameArray.enumerated() {
        //                let offset = namePart.offset
        //                let part = namePart.element
        //
        //                if offset == 0 {
        //                    firstName = part
        //                } else {
        //                    lastName += " \(part)"
        //                }
        //            }
        //        }
        //        firstName = firstName.trim()
        //        lastName = lastName.trim()
        //        return (firstName, lastName)
        
        //            /* Way 2 */
        //            let fullName = "First Last"
        //            let components = fullName.split { !$0.isLetter }.map(String.init) //.map(String($0))
        //            print(components)  // "["First", "Last"]\n"
        
        /* Way 3 */
        // iOS (9.0 and later), macOS (10.11 and later), tvOS (9.0 and later), watchOS (2.0 and later)
        let nameFormatter = PersonNameComponentsFormatter()
        // let name =  "Mr. Steven Paul Jobs Jr."
        // personNameComponents requires iOS (10.0 and later)
        if let nameComps  = nameFormatter.personNameComponents(from: name) {
            //            nameComps.namePrefix   // Mr.
            //            nameComps.givenName    // Steven
            //            nameComps.middleName   // Paul
            //            nameComps.familyName   // Jobs
            //            nameComps.nameSuffix   // Jr.
            if let givenName = nameComps.givenName {
                firstName = givenName
            }
            if let familyName = nameComps.familyName {
                lastName = familyName
            }
            
            // It can also be configured to format your names
            // Default (same as medium), short, long or abbreviated
            
            nameFormatter.style = .default
            nameFormatter.string(from: nameComps)   // "Steven Jobs"
            
            nameFormatter.style = .short
            nameFormatter.string(from: nameComps)   // "Steven"
            
            nameFormatter.style = .long
            nameFormatter.string(from: nameComps)   // "Mr. Steven Paul Jobs jr."
            
            nameFormatter.style = .abbreviated
            nameFormatter.string(from: nameComps)   // SJ
            
            // It can also be use to return an attributed string using annotatedString method
            nameFormatter.style = .long
            nameFormatter.annotatedString(from: nameComps)   // "Mr. Steven Paul Jobs jr."
        }
        
        return (firstName, lastName)
    }
    
    var uppercasedFirstCharacterNew: String {
        if count > 0 {
            let splitIndex = index(after: startIndex)
            let firstCharacter = self[..<splitIndex].uppercased()
            let sentence = self[splitIndex...]
            return firstCharacter + sentence
        } else {
            return self
        }
    }
    
}


//MARK: - Text SubString
/**
 Start Text SubString
 
 https://developer.apple.com/documentation/swift/substring
 
 
 let text = "Hello world"
 let xyz = text[0] // H
 text[...3] // "Hell"
 text[6..<text.count] // world
 text[NSRange(location: 6, length: 3)] // wor
 
 
 */

public extension String {
    subscript(value: Int) -> Character {
        self[index(at: value)]
    }
}

public extension String {
    subscript(value: NSRange) -> Substring {
        self[value.lowerBound..<value.upperBound]
    }
}

public extension String {
    subscript(value: CountableClosedRange<Int>) -> Substring {
        self[index(at: value.lowerBound)...index(at: value.upperBound)]
    }
    
    subscript(value: CountableRange<Int>) -> Substring {
        self[index(at: value.lowerBound)..<index(at: value.upperBound)]
    }
    
    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        self[..<index(at: value.upperBound)]
    }
    
    subscript(value: PartialRangeThrough<Int>) -> Substring {
        self[...index(at: value.upperBound)]
    }
    
    subscript(value: PartialRangeFrom<Int>) -> Substring {
        self[index(at: value.lowerBound)...]
    }
}

private extension String {
    func index(at offset: Int) -> String.Index {
        index(startIndex, offsetBy: offset)
    }
}

public extension String {
    // LEFT
    // Returns the specified number of chars from the left of the string
    // let str = "Hello"
    // print(str.left(3))         // Hel
    func left(_ to: Int) -> String {
        var toIndex = to;
        if (toIndex > self.count) {
            toIndex = self.count;
        } else if (toIndex < 0) {
            toIndex = 0;
        }
        return "\(self[..<self.index(startIndex, offsetBy: toIndex)])"
    }
    
    // RIGHT
    // Returns the specified number of chars from the right of the string
    // let str = "Hello"
    // print(str.left(3))         // llo
    func right(_ from: Int) -> String {
        var fromIndex = from;
        if (fromIndex > self.count) {
            fromIndex = self.count;
        } else if (fromIndex < 0) {
            fromIndex = 0;
        }
        return "\(self[self.index(startIndex, offsetBy: self.count-fromIndex)...])"
    }
    
    // MID
    // Returns the specified number of chars from the startpoint of the string
    // let str = "Hello"
    // print(str.left(2,amount: 2))         // ll
    func mid(_ from: Int, amount: Int = -1) -> String {
        //        let x = "\(self[self.index(startIndex, offsetBy: from)...])"
        //        return x.left(amount)
        var f = from;
        if (f < 0) {
            f = 0;
        }
        let x = "\(self[self.index(startIndex, offsetBy: f)...])"
        return x.left(count == -1 ? x.count : count)
    }
    
    // MIDAFTER
    // Returns the substring that are found after the specified search string
    // let str = "Hello"
    // print(str.midAfter("e"))       // llo
    func midAfter(_ search : String, _ count: Int = -1) -> String {
        let r = self.range(of: search);
        if (r == nil) {
            return "";
        }
        let lb = r!.lowerBound;
        let x = "\(self[lb...])".mid(1);
        return x.left(count == -1 ? x.count : count)
    }
    
    
    func sliceByCharacter(from: Character, to: Character) -> String? {
        let fromIndex = self.index(self.firstIndex(of: from)!, offsetBy: 1)
        let toIndex = self.index(self.firstIndex(of: to)!, offsetBy: -1)
        return String(self[fromIndex...toIndex])
    }
    
    func sliceByString(from:String, to:String) -> String? {
        //From - startIndex
        var range = self.range(of: from)
        let subString = String(self[range!.upperBound...])
        
        //To - endIndex
        range = subString.range(of: to)
        return String(subString[..<range!.lowerBound])
    }
    
    func subString(from: Int, to: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex...endIndex])
    }
    
}
