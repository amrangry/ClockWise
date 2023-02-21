//
//  Bundle+Extension.swift
//  ADKATech.com
//
//  Created by ADKATech.com on 3/13/18.
//  Copyright © 2018 ADKATech.com All rights reserved.
//

import Foundation

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

