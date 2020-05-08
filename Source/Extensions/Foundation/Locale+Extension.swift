//
//  Locale+Extension.swift
//  ADKATech.com
//
//  Created by AmrAngry on 4/21/20.
//  Copyright © 2020 ADKA Tech. All rights reserved.
//

import Foundation

public extension Locale {
    static var preferredLanguageCode: String {
        let defaultLanguage = "en"
        let preferredLanguage = preferredLanguages.first ?? defaultLanguage
        return Locale(identifier: preferredLanguage).languageCode ?? defaultLanguage
        
       // var preferredLanguage : String = Bundle.main.preferredLocalizations.first!
    }

    static var preferredLanguageCodes: [String] {
        return Locale.preferredLanguages.compactMap({Locale(identifier: $0).languageCode})
    }
}
