//
//  Character.swift
//
//  Created by Eli Byrd on 7/15/24.
//

import Foundation

extension Character {
    var utf8Bytes: [UInt8] {
        return Array(String(self).utf8)
    }
}
