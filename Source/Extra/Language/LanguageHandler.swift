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

enum Language: Int {
    case english = 0
    case arabic = 1
}

enum Direction: Int {
    case ltr = 0
    case rtl = 1
}

class LanguageHandler: NSObject {
    
    // singlton implementation
    static var shared = LanguageHandler()
    
    private override init() {
        let userDefaults = UserDefaults(suiteName: languageUserDefaults)!
        let savedLangId = userDefaults.integer(forKey: currentLanguageUserDefaults)
        let savedDirection = userDefaults.integer(forKey: currentDirectionUserDefaults)
        
        let languageId = Language(rawValue: savedLangId) ?? .english
        self.currentLanguage = languageId
        
        let direction = Direction(rawValue: savedDirection) ?? .ltr
        self.currentDirection = direction
        
    }
    
    var currentLanguageModel: LanguageModel {
        if self.currentLanguage == .english { // on for englush
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

// MARK: Helper Prefered methods

extension LanguageHandler {
    
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
        UserDefaults.standard.set([code], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        debugPrint(Locale.autoupdatingCurrent.identifier)
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
