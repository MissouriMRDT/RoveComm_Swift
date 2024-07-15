//
//  RoveComm.swift
//
//  Created by Eli Byrd on 7/15/24.
//

import Foundation
import Network

// MARK: RoveComm Class

/**
 The `RoveComm` class provides functionality for sending UDP packets over a network. It supports sending data in various types such as `UInt8`, `UInt16`, `UInt32`, `Int8`, `Int16`, `Int32`, and `Double`.

 Methods:
 --------
 - sendUDP(_:_:_:_): Sends a UDP packet with the given data type to the specified host and port.
 - createPacket(_:_:): Creates a data packet with the specified header and data.
 - sendUDPPacket(_:_:_): Sends the specified data packet to the given host and port.
 - addressesFor(host:port:): Resolves the IP addresses for the specified host and port.
 */
class RoveComm {
    // MARK: Send UDP

    /**
     Sends a UDP packet with `UInt8` data to the specified host and port.

     - Parameters:
       - host: The host to send the packet to.
       - port: The port to send the packet to.
       - header: The header of the packet.
       - data: The data to be sent.
     */
    func sendUDP(_ host: String, _ port: Int, _ header: RoveCommHeader, _ data: [UInt8]) {
        let packet = createPacket(header, data)
        sendUDPPacket(host, port, packet)
    }

    /**
     Sends a UDP packet with `UInt16` data to the specified host and port.

     - Parameters:
       - host: The host to send the packet to.
       - port: The port to send the packet to.
       - header: The header of the packet.
       - data: The data to be sent.
     */
    func sendUDP(_ host: String, _ port: Int, _ header: RoveCommHeader, _ data: [UInt16]) {
        let packet = createPacket(header, data)
        sendUDPPacket(host, port, packet)
    }

    /**
     Sends a UDP packet with `UInt32` data to the specified host and port.

     - Parameters:
       - host: The host to send the packet to.
       - port: The port to send the packet to.
       - header: The header of the packet.
       - data: The data to be sent.
     */
    func sendUDP(_ host: String, _ port: Int, _ header: RoveCommHeader, _ data: [UInt32]) {
        let packet = createPacket(header, data)
        sendUDPPacket(host, port, packet)
    }

    /**
     Sends a UDP packet with `Int8` data to the specified host and port.

     - Parameters:
       - host: The host to send the packet to.
       - port: The port to send the packet to.
       - header: The header of the packet.
       - data: The data to be sent.
     */
    func sendUDP(_ host: String, _ port: Int, _ header: RoveCommHeader, _ data: [Int8]) {
        let packet = createPacket(header, data)
        sendUDPPacket(host, port, packet)
    }

    /**
     Sends a UDP packet with `Int16` data to the specified host and port.

     - Parameters:
       - host: The host to send the packet to.
       - port: The port to send the packet to.
       - header: The header of the packet.
       - data: The data to be sent.
     */
    func sendUDP(_ host: String, _ port: Int, _ header: RoveCommHeader, _ data: [Int16]) {
        let packet = createPacket(header, data)
        sendUDPPacket(host, port, packet)
    }

    /**
     Sends a UDP packet with `Int32` data to the specified host and port.

     - Parameters:
       - host: The host to send the packet to.
       - port: The port to send the packet to.
       - header: The header of the packet.
       - data: The data to be sent.
     */
    func sendUDP(_ host: String, _ port: Int, _ header: RoveCommHeader, _ data: [Int32]) {
        let packet = createPacket(header, data)
        sendUDPPacket(host, port, packet)
    }

    /**
     Sends a UDP packet with `Double` data to the specified host and port.

     - Parameters:
       - host: The host to send the packet to.
       - port: The port to send the packet to.
       - header: The header of the packet.
       - data: The data to be sent.
     */
    func sendUDP(_ host: String, _ port: Int, _ header: RoveCommHeader, _ data: [Double]) {
        let packet = createPacket(header, data)
        sendUDPPacket(host, port, packet)
    }

    // MARK: Create Packet

    /**
     Creates a data packet with the specified header and `UInt8` data.

     - Parameters:
       - header: The header of the packet.
       - data: The data to be included in the packet.
     - Returns: The created data packet.
     */
    private func createPacket(_ header: RoveCommHeader, _ data: [UInt8]) -> Data {
        var packet = Data([header.version])
        packet.append(contentsOf: header.data_id.twoBytes)
        packet.append(contentsOf: header.data_count.twoBytes)
        packet.append(header.data_type)
        packet.append(contentsOf: data)
        return packet
    }

    /**
     Creates a data packet with the specified header and `UInt16` data.

     - Parameters:
       - header: The header of the packet.
       - data: The data to be included in the packet.
     - Returns: The created data packet.
     */
    private func createPacket(_ header: RoveCommHeader, _ data: [UInt16]) -> Data {
        var packet = Data([header.version])
        packet.append(contentsOf: header.data_id.twoBytes)
        packet.append(contentsOf: header.data_count.twoBytes)
        packet.append(header.data_type)
        for value in data {
            packet.append(contentsOf: value.twoBytes)
        }
        return packet
    }

    /**
     Creates a data packet with the specified header and `UInt32` data.

     - Parameters:
       - header: The header of the packet.
       - data: The data to be included in the packet.
     - Returns: The created data packet.
     */
    private func createPacket(_ header: RoveCommHeader, _ data: [UInt32]) -> Data {
        var packet = Data([header.version])
        packet.append(contentsOf: header.data_id.twoBytes)
        packet.append(contentsOf: header.data_count.twoBytes)
        packet.append(header.data_type)
        for value in data {
            packet.append(contentsOf: value.fourBytes)
        }
        return packet
    }

    /**
     Creates a data packet with the specified header and `Int8` data.

     - Parameters:
       - header: The header of the packet.
       - data: The data to be included in the packet.
     - Returns: The created data packet.
     */
    private func createPacket(_ header: RoveCommHeader, _ data: [Int8]) -> Data {
        var packet = Data([header.version])
        packet.append(contentsOf: header.data_id.twoBytes)
        packet.append(contentsOf: header.data_count.twoBytes)
        packet.append(header.data_type)
        for value in data {
            packet.append(contentsOf: withUnsafeBytes(of: value) { Array($0) })
        }
        return packet
    }

    /**
     Creates a data packet with the specified header and `Int16` data.

     - Parameters:
       - header: The header of the packet.
       - data: The data to be included in the packet.
     - Returns: The created data packet.
     */
    private func createPacket(_ header: RoveCommHeader, _ data: [Int16]) -> Data {
        var packet = Data([header.version])
        packet.append(contentsOf: header.data_id.twoBytes)
        packet.append(contentsOf: header.data_count.twoBytes)
        packet.append(header.data_type)
        for value in data {
            packet.append(contentsOf: value.twoBytes)
        }
        return packet
    }

    /**
     Creates a data packet with the specified header and `Int32` data.

     - Parameters:
       - header: The header of the packet.
       - data: The data to be included in the packet.
     - Returns: The created data packet.
     */
    private func createPacket(_ header: RoveCommHeader, _ data: [Int32]) -> Data {
        var packet = Data([header.version])
        packet.append(contentsOf: header.data_id.twoBytes)
        packet.append(contentsOf: header.data_count.twoBytes)
        packet.append(header.data_type)
        for value in data {
            packet.append(contentsOf: value.fourBytes)
        }
        return packet
    }

    /**
     Creates a data packet with the specified header and `Double` data.

     - Parameters:
       - header: The header of the packet.
       - data: The data to be included in the packet.
     - Returns: The created data packet.
     */
    private func createPacket(_ header: RoveCommHeader, _ data: [Double]) -> Data {
        var packet = Data([header.version])
        packet.append(contentsOf: header.data_id.twoBytes)
        packet.append(contentsOf: header.data_count.twoBytes)
        packet.append(header.data_type)
        for value in data {
            packet.append(contentsOf: value.eightBytes)
        }
        return packet
    }

    // MARK: Send UDP Packet

    /**
     Sends the specified data packet to the given host and port.

     - Parameters:
       - host: The host to send the packet to.
       - port: The port to send the packet to.
       - packet: The data packet to be sent.
     */
    private func sendUDPPacket(_ host: String, _ port: Int, _ packet: Data) {
        let ipAddr = host.count > 3 ? host : "192.168.201.\(String(host.suffix(3)))"

        guard let addresses = try? addressesFor(host: ipAddr, port: port), !addresses.isEmpty else {
            print("host not found")
            return
        }

        let address = addresses[0]
        let fd = socket(Int32(address.sin_family), SOCK_DGRAM, 0)
        guard fd >= 0 else {
            print("`socket` failed")
            return
        }
        defer { close(fd) }

        let sendResult = packet.withUnsafeBytes { (messagePtr: UnsafeRawBufferPointer) -> Int in
            address.withSockAddr { sa, saLen -> Int in
                sendto(fd, messagePtr.baseAddress, packet.count, 0, sa, saLen)
            }
        }

        guard sendResult >= 0 else {
            print("send failed")
            return
        }
    }

    // MARK: Addresses Config

    /**
     Resolves the IP addresses for the specified host and port.

     - Parameters:
       - host: The host to resolve.
       - port: The port to resolve.
     - Returns: An array of resolved `sockaddr_in` addresses.
     - Throws: An `NSError` if address resolution fails.
     */
    private func addressesFor(host: String, port: Int) throws -> [sockaddr_in] {
        var hints = addrinfo(
            ai_flags: 0,
            ai_family: AF_INET,
            ai_socktype: SOCK_DGRAM,
            ai_protocol: 0,
            ai_addrlen: 0,
            ai_canonname: nil,
            ai_addr: nil,
            ai_next: nil
        )

        var info: UnsafeMutablePointer<addrinfo>?
        let status = getaddrinfo(host, String(port), &hints, &info)

        guard status == 0, let info = info else {
            throw NSError(domain: NSPOSIXErrorDomain, code: Int(status), userInfo: nil)
        }

        var addresses = [sockaddr_in]()
        for ptr in sequence(first: info, next: { $0.pointee.ai_next }) {
            if ptr.pointee.ai_family == AF_INET {
                if let addr = ptr.pointee.ai_addr?.withMemoryRebound(to: sockaddr_in.self, capacity: 1, { $0.pointee }) {
                    addresses.append(addr)
                }
            }
        }

        freeaddrinfo(info)
        return addresses
    }
}
