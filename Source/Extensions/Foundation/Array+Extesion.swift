//
//  Array+Extesion.swift
//  Resturant
//
//  Created by Amr Elghadban (AmrAngry) on 7/17/19.
//  Copyright © 2019 adka. All rights reserved.
//

import Foundation

public extension Array {
    func object(at index: Int) -> Element? {
        guard self.isEmpty == false, index >= 0, index < self.count else { return nil }
        let element = self[index]
        return element
    }
}
