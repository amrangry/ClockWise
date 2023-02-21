//
//  Bundle+Extension+Language.swift
//  ClockWise
//
//  Created by Amr Elghadban on 06/01/2023.
//  Copyright © 2023 ADKATech.com All rights reserved.
//

import Foundation

// MARK: - Localization + Bundle
/// Localization + Bundle
public extension Bundle {
    
    //Here magic happens
    //when you localize resources: for instance Localizable.strings, images
    //it creates different bundles
    //we take appropriate bundle according to language
    static var localizedBundle: Bundle {
        let languageCode = LanguageManager.shared.currentLanguage.code
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj") else {
            //let path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
            return .main
        }
        guard let localizedBundle = Bundle(path: path) else {
            return .main
        }
        return localizedBundle
    }
    
    //  var preferredLanguage : String = Bundle.main.preferredLocalizations.first! // return last saved before restart app
    
}
