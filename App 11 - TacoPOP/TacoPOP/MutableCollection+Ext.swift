//
//  MutableCollection+Ext.swift
//  TacoPOP
//
//  Created by Per Kristensen on 18/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import Foundation

extension MutableCollection where Index == Int {
    mutating func shuffle() {
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + 1
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}
