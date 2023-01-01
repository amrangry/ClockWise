//
//  LanguageHandler.swift
//  test
//
//  Created by Karim Mousa on 1/27/18.
//  Copyright © 2018 Karim Mousa. All rights reserved.
//

import UIKit
// user defaults

private let languageUserDefaults = "languageUserDefaults"
private let currentLanguageUserDefaults = "currentLanguageUserDefaults"
private let currentDirectionUserDefaults = "currentDirectionUserDefaults"
private let appleLanguageKey = "AppleLanguages"

public enum Language: Int {
    case english = 0
    case arabic = 1
}

public enum Direction: Int {
    case ltr = 0
    case rtl = 1
}

public class LanguageManager: NSObject {
    
    // singleton implementation
    static var shared = LanguageManager()
    
    private override init() {
        userDefaults = UserDefaults.standard//UserDefaults(suiteName: languageUserDefaults)!
        let savedLangId = userDefaults.integer(forKey: currentLanguageUserDefaults)
        let savedDirection = userDefaults.integer(forKey: currentDirectionUserDefaults)
        
        let languageId = Language(rawValue: savedLangId) ?? .english
        self.currentLanguage = languageId
        
        let direction = Direction(rawValue: savedDirection) ?? .ltr
        self.currentDirection = direction
    }
    
    var userDefaults: UserDefaults
    
    var currentLanguageModel: LanguageModel {
        if self.currentLanguage == .english { // on for English
            return LanguageModel.english
        } else { // off arabic
            return LanguageModel.arabic
        }
    }
    
    var currentLanguage: Language {
        willSet {
            let defaults: UserDefaults = UserDefaults(suiteName: languageUserDefaults)!
            defaults.set(newValue.rawValue, forKey: currentLanguageUserDefaults)
            defaults.synchronize()
        }
    }
    
    var currentDirection: Direction {
        willSet {
            let defaults: UserDefaults = UserDefaults(suiteName: languageUserDefaults)!
            defaults.set(newValue.rawValue, forKey: currentDirectionUserDefaults)
            defaults.synchronize()
        }
    }
    
    var localizedResourcesBundle: Bundle {
        let lang: String = (currentLanguage == .arabic) ? "ar" : "en"
        let bundlePath: String = Bundle.main.path(forResource: lang, ofType: "lproj")!
        let bundle = Bundle(path: bundlePath)!
        return bundle
    }
    
    func localizedNameForResourceWithName(_ resourceName: String) -> String {
        return "\(resourceName)_" + ((self.currentDirection == .rtl) ? "RTL" : "LTR")
    }
    
    func stringForKey(_ key: String) -> String {
        return self.localizedResourcesBundle.localizedString(forKey: key, value: "\(key)", table: nil)
    }
    
}

// MARK: Helper Preferred methods

public extension LanguageManager {
    
    func getSupportedLanguages() -> [LanguageModel] {
        let arabicLang = LanguageModel.arabic
        let englishLang = LanguageModel.english
        let languageList = [englishLang, arabicLang]
        return languageList
    }

    func getPreferredLanguageCodePreferred() -> String {
        let preferred = Bundle.main.preferredLocalizations.first ?? "en"
        return preferred
    }
    
    func getCurrentLanguageCode() -> String {
        let code = (currentLanguage == .arabic) ? "ar" : "en"
        return code
    }
    
    func configureAppLanguage(_ code: String) {
        if code == "en" {
            currentLanguage = .english
            currentDirection = .ltr
        } else {
            currentLanguage = .arabic
            currentDirection = .rtl
        }
        userDefaults.set([code], forKey: appleLanguageKey)
        userDefaults.synchronize()
        debugPrint(Locale.autoupdatingCurrent.identifier)
    }
    
    /// get current Apple language
    func currentAppleLanguage() -> AppLanguages {
        guard let langArray = userDefaults.object(forKey: appleLanguageKey) as? [String] else { return .en }
        guard let current = langArray.first else { return .en }
        guard let currentLang = AppLanguages(rawValue: current) else { return .en }
        return currentLang
    }
    
    /// set @lang to be the first in Apple languages list
    func setAppLanguageTo(lang: AppLanguages) {
        userDefaults.set([lang.rawValue, currentAppleLanguage().rawValue], forKey: appleLanguageKey)
        userDefaults.synchronize()
    }
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
