//
//  Optional+Extension.swift
//  MotoShop
//
//  Created by AmrAngry on 4/22/20.
//  Copyright © 2020 ADKA Tech. All rights reserved.
//

import Foundation

public extension Optional {
    
    func isNil() -> Bool {
        self == nil
    }
    
}

public extension Optional where Wrapped == Bool {
    
    func isTrue() -> Bool {
        self == true
    }
    
    func isFalse() -> Bool {
        self == false
    }
    
}

public extension Optional where Wrapped: Collection {
    
    func isNilOrEmpty() -> Bool {
        self == nil || self?.isEmpty == true
    }
    
}
