//
//  Bundle+Extension.swift
//  ADKATech.com
//
//  Created by ADKATech.com on 3/13/18.
//  Copyright © 2018 ADKATech.com All rights reserved.
//

import Foundation

public extension Bundle {
    
    @objc func specialLocalizedString(key: String, value: String?, table tableName: String?) -> String {
        let currentLanguage = LanguageManager.shared.currentAppleLanguage()
        var bundle: Bundle
        if let path = Bundle.main.path(forResource: currentLanguage.rawValue, ofType: "lproj") {
            bundle = Bundle(path: path)!
        } else {
            let path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
            bundle = Bundle(path: path)!
        }
        return bundle.specialLocalizedString(key: key, value: value, table: tableName)
    }
}

public extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    var applicationName: String {
        return infoDictionary?["CFBundleDisplayName"] as? String ?? "ADKATech"
    }
    
    var applicationReleaseDate: String {
        return infoDictionary?["ApplicationReleaseDate"] as? String ?? Date().description
    }
    
    var applicationReleaseNumber: Int {
        return infoDictionary?["ApplicationReleaseNumber"] as? Int ?? 0
    }
    
    var releaseVersionNumberPretty: String {
        return "\(releaseVersionNumber ?? "1.0.0")"
    }
    
    var buildVersionNumberPretty: String {
        return "\(buildVersionNumber ?? "1")"
    }
}
