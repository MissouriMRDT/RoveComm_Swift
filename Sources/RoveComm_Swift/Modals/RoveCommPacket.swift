//
//  RoveCommPacket.swift
//
//  Created by Eli Byrd on 7/15/24.
//

import Foundation

struct RoveCommPacket {
    var header: RoveCommHeader
    var data: [UInt8]
}
