//
//  String+Extension+Language.swift
//  ClockWise
//
//  Created by Amr Elghadban on 06/01/2023.
//  Copyright © 2023 ADKATech.com All rights reserved.
//

import Foundation

// MARK: - Localization
/// Localization + String
public extension String {

    /// localized
    var localized: String {
//        let langKey = LanguageManager.shared.getCurrentLanguage()
//        var bundle: Bundle?
//        if let localizationFilePath = Bundle.main.path(forResource: langKey, ofType: "lproj"), let localizedBundle = Bundle(path: localizationFilePath) {
//            bundle = localizedBundle
//        }
//        let value = LanguageManager.shared.localized(bundle: bundle ?? .main)
        let translatedValue = LanguageManager.shared.localizedValue(forKey: self)
        return translatedValue
    }
    
}
