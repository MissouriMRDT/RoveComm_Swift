//
//  Int32.swift
//
//  Created by Eli Byrd on 7/15/24.
//

import Foundation

extension Int32 {
    var fourBytes: [UInt8] {
        return [
            UInt8((self >> 24) & 0xFF),
            UInt8((self >> 16) & 0xFF),
            UInt8((self >> 8) & 0xFF),
            UInt8(self & 0xFF)
        ]
    }
}
