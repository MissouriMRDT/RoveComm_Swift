//
//  Int16.swift
//
//  Created by Eli Byrd on 7/15/24.
//

import Foundation

extension Int16 {
    var twoBytes: [UInt8] {
        return [UInt8(self >> 8), UInt8(self & 0xFF)]
    }
}
