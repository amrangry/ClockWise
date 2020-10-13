//
//  MutableCollection+Extension.swift
//  ClockWise
//
//  Created by AmrAngry on 5/20/20.
//

import Foundation

public extension MutableCollection where Index == Int {
    
    mutating func shuffle() {
        if count <= 1 { return }
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swapAt(i, j)
        }
    }
    
}
