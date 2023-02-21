//
//  LanguageManager.swift
//  test
//
//  Created by Amr Elghadban on 04/01/2023.
//  Copyright © 2023 ADKATech.com All rights reserved.
//

import UIKit
// user defaults

//Showing Recent Messages
//Build input files cannot be found: '/Users/amr/Workspace2021/Amr/ADKA/ADKATech_Github_Repos/AseerAlkotob_BookJuice/repo/AseerAlkotob_BookJuice_iOS/Pods/ClockWise/Source/Extra/Language/AppLanguages.swift', '/Users/amr/Workspace2021/Amr/ADKA/ADKATech_Github_Repos/AseerAlkotob_BookJuice/repo/AseerAlkotob_BookJuice_iOS/Pods/ClockWise/Source/Extensions/Foundation/Locale+Extension.swift', '/Users/amr/Workspace2021/Amr/ADKA/ADKATech_Github_Repos/AseerAlkotob_BookJuice/repo/AseerAlkotob_BookJuice_iOS/Pods/ClockWise/Source/Extra/Language/LanguageModel.swift'. Did you forget to declare these files as outputs of any script phases or custom build rules which produce them?

private let languageUserDefaults = "languageUserDefaults"
private let currentLanguageUserDefaults = "currentLanguageUserDefaults"
private let currentDirectionUserDefaults = "currentDirectionUserDefaults"
private let appleLanguageKey = "AppleLanguages"

public enum AppDirection: Int {
    case ltr = 1
    case rtl = 2
    
    public var value: Int {
        self.rawValue
    }
    
    public var code: String {
        switch self {
        case .ltr:
            return "ltr"//"LTR"
        case .rtl:
            return "rtl"//"RTL"
        }
    }
    
   public static func retrieve(forLanguageCode code: String) -> AppDirection? {
        switch code {
        case AppLanguage.english.code:
            return .ltr
        case AppLanguage.arabic.code:
            return .rtl
        default:
            return nil
        }
    }
}

public enum AppLanguage: Int {
    
    case english = 1
    case arabic = 2
    
    public var value: Int {
        self.rawValue
    }
    
    public var code: String {
        switch self {
        case .english:
            return "en"
        case .arabic:
            return "ar"
        }
    }
    
    public var localizedName: String {
        switch self {
        case .english:
            return "English"
        case .arabic:
            return "عربي"
        }
    }
    
    public var direction: AppDirection {
        switch self {
        case .english:
            return AppDirection.ltr
        case .arabic:
            return AppDirection.rtl
        }
    }
    
    public func convert() -> LanguageModel {
        LanguageModel.make(for: self)
    }
    
    public static func retrieve(for code: String) -> AppLanguage? {
        switch code {
        case AppLanguage.english.code:
            return .english
        case AppLanguage.arabic.code:
            return .arabic
        default:
            return nil
        }
    }

}

public struct LanguageModel {
    public let id: Int?
    public let code: String?
    public let name: String?
    public let direction: AppDirection?
    
    public static func make(for appLanguage: AppLanguage) -> LanguageModel {
        LanguageModel(id: appLanguage.value, code: appLanguage.code, name: appLanguage.localizedName, direction: appLanguage.direction)
    }
}

public extension LanguageModel {
    static let english = LanguageModel.make(for: AppLanguage.english)
    static let arabic = LanguageModel.make(for: AppLanguage.arabic)
}

public class LanguageManager: NSObject {
    
    
    // singleton implementation
    public static var shared = LanguageManager()
    public static let imageFlipFlag = 200
    var userDefaults: UserDefaults
    
    private override init() {
        let code = LanguageManager.preferredLanguageCode
        
        userDefaults = UserDefaults(suiteName: languageUserDefaults)!
        let savedLangId = userDefaults.integer(forKey: currentLanguageUserDefaults)
        let savedDirection = userDefaults.integer(forKey: currentDirectionUserDefaults)
        
        var language: AppLanguage
        if let value = AppLanguage(rawValue: savedLangId) {
            language = value
        } else {
            if let value = AppLanguage.retrieve(for: code) {
                language = value
            } else {
                language = .english
            }
        }
        currentLanguage = language
        
        var direction: AppDirection
        if let value = AppDirection(rawValue: savedDirection) {
            direction = value
        } else {
            if let value = AppDirection.retrieve(forLanguageCode: code) {
                direction = value
            } else {
                direction = .ltr
            }
        }
        currentDirection = direction
        
        /* using cache method as the willSet and didSet will not be called while invoked from init of object*/
        LanguageManager.cache(value: language.value, key: currentLanguageUserDefaults, userDefaults: userDefaults)
        LanguageManager.cache(value: direction.value, key: currentDirectionUserDefaults, userDefaults: userDefaults)
    }
    
    public static var preferredLanguageCode: String {
        let preferred = Locale.preferredLanguageCode
        return preferred
    }
    
    public var currentLanguageModel: LanguageModel {
        if self.currentLanguage == .english { // on for English
            return LanguageModel.english
        } else { // off arabic
            return LanguageModel.arabic
        }
    }
    
    public var currentLanguage: AppLanguage {
        willSet {
            let defaults = UserDefaults(suiteName: languageUserDefaults)
            let value = newValue.rawValue
            LanguageManager.cache(value: value, key: currentLanguageUserDefaults, userDefaults: defaults)
        }
    }
    
    public var currentDirection: AppDirection {
        didSet {
            let defaults = UserDefaults(suiteName: languageUserDefaults)!
            let value = currentDirection.value
            LanguageManager.cache(value: value, key: currentDirectionUserDefaults, userDefaults: defaults)
        }
    }
    
    private static func cache(value: Any, key: String, userDefaults: UserDefaults?) {
        userDefaults?.set(value, forKey: key)
        userDefaults?.synchronize()
    }
    
    public var localizedBundle: Bundle {
        Bundle.localizedBundle
    }
    
    func localizedValue(forKey key: String) -> String {
        localizedBundle.localizedString(forKey: key, value: "\(key)", table: nil)
        //NSLocalizedString(self, tableName: tableName, bundle: .main, value: self, comment: "")
    }
    
    func localizedNameForResourceWithName(_ resourceName: String) -> String {
        "\(resourceName)_" + currentDirection.code//((self.currentDirection == .rtl) ? "RTL" : "LTR")
    }
    
    func localized(_ key: String, bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        //return NSLocalizedString(self, comment: "")
        let value = NSLocalizedString(key, tableName: tableName, bundle: .main, value: key, comment: "")
        return value
    }
    
//    var localizedImage: UIImage? {
//        return localizedImage()
//            ?? localizedImage(type: ".png")
//            ?? localizedImage(type: ".jpg")
//            ?? localizedImage(type: ".jpeg")
//            ?? UIImage(named: self)
//    }
//
//    private func localizedImage(type: String = "") -> UIImage? {
//        guard let imagePath = Bundle.localizedBundle.path(forResource: self, ofType: type) else {
//            return nil
//        }
//        return UIImage(contentsOfFile: imagePath)
//    }

}

// MARK: Helper Preferred methods
public extension LanguageManager {
    
    func getSupportedLanguages() -> [LanguageModel] {
        let arabicLang = LanguageModel.arabic
        let englishLang = LanguageModel.english
        let languageList = [englishLang, arabicLang]
        return languageList
    }
    
    func getCurrentLanguage() -> String {
        let code = currentLanguage.code
        return code
    }
    
    func configureLanguage(_ code: String) {
        if code == AppLanguage.english.code {
            currentLanguage = .english
            currentDirection = .ltr
        } else {
            currentLanguage = .arabic
            currentDirection = .rtl
        }
        userDefaults.set([code], forKey: appleLanguageKey)
        userDefaults.synchronize()
        
        //change language in the app
        //the language will be changed after restart
        UserDefaults.standard.set([code], forKey: appleLanguageKey)
        UserDefaults.standard.synchronize()
    }
    
    func configureAppLanguage(_ object: LanguageModel) {
        guard let code = object.code else { return }
        configureLanguage(code)
    }
    
    
    //appLanguageSettings
    //launch to app settings is the best way to allow user to switch language to your app
  
}

///**
// reset app which will perform transition and call reset on appdelegate if it's MOLHResetable
// */
//open class func reset() {
//    var transition = UIView.AnimationOptions.transitionFlipFromRight
//    if !MOLHLanguage.isRTLLanguage() {
//        transition = .transitionFlipFromLeft
//    }
//    reset(transition: transition)
//}
//
//open class func reset(transition: UIView.AnimationOptions) {
//    if let delegate = UIApplication.shared.delegate {
//        if delegate is MOLHResetable {
//            (delegate as!MOLHResetable).reset()
//        }
//        UIView.transition(with: ((delegate.window)!)!, duration: 0.5, options: transition, animations: {}) { (f) in
//        }
//    }
//}
