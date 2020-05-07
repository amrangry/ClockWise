//
//  LanguageModel.swift
//  Awoon
//
//  Created by AdKa on 12/23/17.
//  Copyright © 2017 AdKa  Inc. All rights reserved.
//

import Foundation

struct LanguageModel {
    let id: Int?
    let code: String?
    let name: String?
}

extension LanguageModel {
    static let arabic = LanguageModel(id: 2, code: "ar", name: "عربي")
    static let english = LanguageModel(id: 1, code: "en", name: "English")
}
