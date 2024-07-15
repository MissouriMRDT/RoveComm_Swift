//
//  sockaddr_in.swift
//
//  Created by Eli Byrd on 7/15/24.
//

import Foundation

extension sockaddr_in {
    func withSockAddr<T>(_ body: (UnsafePointer<sockaddr>, socklen_t) -> T) -> T {
        var addr = self
        return withUnsafePointer(to: &addr) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                body($0, socklen_t(MemoryLayout<sockaddr_in>.size))
            }
        }
    }
}
