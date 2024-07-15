//
//  UInt16.swift
//
//  Created by Eli Byrd on 7/15/24.
//

import Foundation

extension UInt16 {
    var twoBytes: [UInt8] {
        return [UInt8(self >> 8), UInt8(self & 0xFF)]
    }
}
