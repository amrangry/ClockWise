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
        let defaultLanguage = AppLanguage.english.code
        var preferredLanguage = defaultLanguage
        if let value = preferredLanguages.first {
            preferredLanguage = value
        }
        var result = ""
        if let value = Locale(identifier: preferredLanguage).languageCode {
            result = value
        } else {
            result = preferredLanguage
        }
        //  let xyz5 = Locale.autoupdatingCurrent.identifier  // return last saved before restart app
        //  let xyz4 = Locale.preferredLanguageCode // return updated one regardless restart app
        
        
        return result
    }
    
    
    /// return System User preferredLanguage codes regardless of application supported bundled
    static var preferredLanguageCodes: [String] {
        return Locale.preferredLanguages.compactMap({Locale(identifier: $0).languageCode})
    }
    
}
