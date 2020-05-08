//
//  Language.swift
//  onNet
//
//  Created by ADKATech.com on 3/13/18.
//  Copyright © 2018 ADKATech.com All rights reserved.
//

import Foundation



public class LanguageManager {
    
    static let shared = LanguageManager()
    
    private init() {}
    
    /// get current Apple language
    func currentAppleLanguage() -> AppLanguages {
//        let userdef = UserDefaults.standard
//        guard let langArray = userdef.object(forKey: Keys.appleLanguages.rawValue) as? [String] else {return .en}
//        guard let current = langArray.first else {return .en}
//        guard let currentLang = AppLanguages(rawValue: current) else { return .en }
        return .en
    }
    
    /// set @lang to be the first in Applelanguages list
    func setAppleLAnguageTo(lang: AppLanguages) {
//        let userdef = UserDefaults.standard
//        userdef.set([lang.rawValue, currentAppleLanguage().rawValue], forKey: Keys.appleLanguages.rawValue)
//        userdef.synchronize()
    }
    
}
