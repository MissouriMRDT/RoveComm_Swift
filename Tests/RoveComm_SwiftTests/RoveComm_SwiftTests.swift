//
//  RoveComm_SwiftTests.swift
//
//  Created by Eli Byrd on 7/15/24.
//

import Network
@testable import RoveComm_Swift
import XCTest

// MARK: RoveComm Swift Tests Class

/**
 The `RoveComm_SwiftTests` class contains unit tests for the `RoveComm` class. It verifies that UDP packets are correctly sent and received for various data types.

 Methods:
 --------
 - setUp(): Sets up the test environment.
 - tearDown(): Tears down the test environment.
 - testSendUInt8(): Tests sending `UInt8` data.
 - testSendUInt16(): Tests sending `UInt16` data.
 - testSendUInt32(): Tests sending `UInt32` data.
 - testSendInt8(): Tests sending `Int8` data.
 - testSendInt16(): Tests sending `Int16` data.
 - testSendInt32(): Tests sending `Int32` data.
 - testSendFloat(): Tests sending `Float` data.
 - testSendDouble(): Tests sending `Double` data.
 - testSendCharacter(): Tests sending `Character` data.
 - sendAndVerify(header:data:): Sends data and verifies the received packet.
 - convertToUInt8Array(_:): Converts various data types to an array of `UInt8`.
 */
final class RoveComm_SwiftTests: XCTestCase {
    // MARK: Variables and Constants

    let roveComm = RoveComm()
    var listener: RoveCommListener!
    var receivedPacket: RoveCommPacket?
    var expectation: XCTestExpectation?

    // MARK: Setup

    /**
     Sets up the test environment, initializing the listener and its packet handler.
     */
    override func setUp() {
        super.setUp()
        listener = RoveCommListener(port: 11000)
        listener.packetHandler = { [weak self] packet in
            self?.receivedPacket = packet
            self?.expectation?.fulfill()
        }
        listener.startListening()
    }

    // MARK: Tear Down

    /**
     Tears down the test environment, stopping the listener and clearing references.
     */
    override func tearDown() {
        listener.stopListening()
        listener = nil
        receivedPacket = nil
        expectation = nil
        super.tearDown()
    }

    // MARK: Test UInt8

    /**
     Tests sending `UInt8` data.
     */
    func testSendUInt8() {
        // DataID: 3008
        // DataCount: 3
        // DataType: 1
        let header = RoveCommHeader(version: 3, data_id: 3008, data_count: 3, data_type: 1)
        let data: [UInt8] = [1, 2, 3]
        sendAndVerify(header: header, data: data)
    }

    // MARK: Test UInt16

    /**
     Tests sending `UInt16` data.
     */
    func testSendUInt16() {
        // DataID: 8102
        // DataCount: 1
        // DataType: 3
        let header = RoveCommHeader(version: 3, data_id: 8102, data_count: 1, data_type: 3)
        let data: [UInt16] = [1, 2, 3, 4, 5]
        sendAndVerify(header: header, data: data)
    }

    // MARK: Test UInt32

    /**
     Tests sending `UInt32` data.
     */
    func testSendUInt32() {
        // DataID: 16001
        // DataCount: 1
        // DataType: 5
        let header = RoveCommHeader(version: 3, data_id: 16001, data_count: 1, data_type: 5)
        let data: [UInt32] = [1, 2, 3, 4, 5]
        sendAndVerify(header: header, data: data)
    }

    // MARK: Test Int8

    /**
     Tests sending `Int8` data.
     */
    func testSendInt8() {
        // DataID: 16106
        // DataCount: 1
        // DataType: 0
        let header = RoveCommHeader(version: 3, data_id: 16106, data_count: 1, data_type: 0)
        let data: [Int8] = [1, 2, 3, 4, 5]
        sendAndVerify(header: header, data: data)
    }

    // MARK: Test Int16

    /**
     Tests sending `Int16` data.
     */
    func testSendInt16() {
        // DataID: 3006
        // DataCount: 2
        // DataType: 2
        let header = RoveCommHeader(version: 3, data_id: 3006, data_count: 2, data_type: 2)
        let data: [Int16] = [1, 2, 3, 4, 5]
        sendAndVerify(header: header, data: data)
    }

    // MARK: Test Int32

    /**
     Tests sending `Int32` data.
     */
    func testSendInt32() {
        // DataID: 17001
        // DataCount: 1
        // DataType: 4
        let header = RoveCommHeader(version: 3, data_id: 17001, data_count: 1, data_type: 4)
        let data: [Int32] = [1, 2, 3, 4, 5]
        sendAndVerify(header: header, data: data)
    }

    // MARK: Test Float

    /**
     Tests sending `Float` data.
     */
    func testSendFloat() {
        // DataID: 20001
        // DataCount: 2
        // DataType: 6
        let header = RoveCommHeader(version: 3, data_id: 20001, data_count: 2, data_type: 6)
        let data: [Float] = [1.0, 2.0, 3.0, 4.0, 5.0]
        sendAndVerify(header: header, data: data)
    }

    // MARK: Test Double

    /**
     Tests sending `Double` data.
     */
    func testSendDouble() {
        // DataID: 6100
        // DataCount: 3
        // DataType: 7
        let header = RoveCommHeader(version: 3, data_id: 6100, data_count: 3, data_type: 7)
        let data: [Double] = [1.0, 2.0, 3.0, 4.0, 5.0]
        sendAndVerify(header: header, data: data)
    }

    // MARK: Test Character

    /**
     Tests sending `Character` data.
     */
    func testSendCharacter() {
        // DataID: 31000
        // DataCount: 5
        // DataType: 8
        let header = RoveCommHeader(version: 3, data_id: 31000, data_count: 5, data_type: 8)
        let data: [Character] = ["a", "b", "c", "d", "e"]
        sendAndVerify(header: header, data: data)
    }

    // MARK: Send and Verify

    /**
     Sends data and verifies the received packet.

     - Parameters:
       - header: The header of the packet.
       - data: The data to be sent.
     */
    private func sendAndVerify<T>(header: RoveCommHeader, data: [T]) {
        expectation = expectation(description: "Waiting for packet")
        let address = "localhost"
        let port = 11000

        // Send data
        if let data = data as? [UInt8] {
            roveComm.sendUDP(address, port, header, data)
        } else if let data = data as? [UInt16] {
            roveComm.sendUDP(address, port, header, data)
        } else if let data = data as? [UInt32] {
            roveComm.sendUDP(address, port, header, data)
        } else if let data = data as? [Int8] {
            roveComm.sendUDP(address, port, header, data)
        } else if let data = data as? [Int16] {
            roveComm.sendUDP(address, port, header, data)
        } else if let data = data as? [Int32] {
            roveComm.sendUDP(address, port, header, data)
        } else if let data = data as? [Float] {
            roveComm.sendUDP(address, port, header, data)
        } else if let data = data as? [Double] {
            roveComm.sendUDP(address, port, header, data)
        } else if let data = data as? [Character] {
            roveComm.sendUDP(address, port, header, data)
        }

        waitForExpectations(timeout: 15) { error in
            XCTAssertNil(error, "Failed to receive packet in time")
            XCTAssertNotNil(self.receivedPacket, "No packet received")
            XCTAssertEqual(self.receivedPacket?.data, self.convertToUInt8Array(data), "Data mismatch")
        }
    }

    // MARK: Convert to UInt8 Array

    /**
     Converts various data types to an array of `UInt8`.

     - Parameter data: The data to convert.
     - Returns: An array of `UInt8` representing the data.
     */
    private func convertToUInt8Array<T>(_ data: [T]) -> [UInt8] {
        var byteArray: [UInt8] = []
        for value in data {
            if let value = value as? UInt16 {
                byteArray.append(contentsOf: value.twoBytes)
            } else if let value = value as? Int16 {
                byteArray.append(contentsOf: value.twoBytes)
            } else if let value = value as? UInt32 {
                byteArray.append(contentsOf: value.fourBytes)
            } else if let value = value as? Int32 {
                byteArray.append(contentsOf: value.fourBytes)
            } else if let value = value as? Float {
                byteArray.append(contentsOf: value.fourBytes)
            } else if let value = value as? Double {
                byteArray.append(contentsOf: value.eightBytes)
            } else if let value = value as? Character {
                byteArray.append(contentsOf: value.utf8Bytes)
            } else {
                byteArray.append(contentsOf: withUnsafeBytes(of: value) { Array($0) })
            }
        }
        return byteArray
    }
}
