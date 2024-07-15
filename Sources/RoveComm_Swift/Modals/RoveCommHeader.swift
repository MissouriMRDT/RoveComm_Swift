//
//  RoveCommHeader.swift
//
//  Created by Eli Byrd on 7/15/24.
//

import Foundation

struct RoveCommHeader {
    var version: UInt8
    var data_id: UInt16
    var data_count: UInt16
    var data_type: UInt8
}
