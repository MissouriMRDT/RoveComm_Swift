//
//  RoveCommListener.swift
//
//  Created by Eli Byrd on 7/15/24.
//

import Foundation
import Network

// MARK: RoveComm Listner Class

/**
 The `RoveCommListener` class listens for incoming UDP packets on a specified port. It decodes the received packets and handles them using a provided packet handler.

 Note: This class is only available on macOS 10.14 and later.

 Methods:
 --------
 - startListening(): Starts listening for incoming connections on the specified port.
 - stopListening(): Stops the listener.
 - receive(on:): Receives data from a connection.
 - decodePacket(data:): Decodes the received data into a `RoveCommPacket`.
 */

@available(macOS 10.14, *)
class RoveCommListener {
    // MARK: Variables and Constants

    let port: NWEndpoint.Port
    var listener: NWListener?
    var packetHandler: ((RoveCommPacket) -> Void)?

    // MARK: Initializer

    /**
     Initializes a new `RoveCommListener` with the specified port.

     - Parameter port: The port to listen on.
     */
    init(port: UInt16) {
        self.port = NWEndpoint.Port(rawValue: port) ?? NWEndpoint.Port(11000)
    }

    // MARK: Start Listener

    /**
     Starts listening for incoming connections on the specified port.
     */
    func startListening() {
        do {
            listener = try NWListener(using: .udp, on: port)
            listener?.stateUpdateHandler = { newState in
                switch newState {
                case .ready:
                    print("Listener ready on port \(self.port)")
                default:
                    break
                }
            }
            listener?.newConnectionHandler = { connection in
                connection.stateUpdateHandler = { newState in
                    switch newState {
                    case .ready:
                        self.receive(on: connection)
                    default:
                        break
                    }
                }
                connection.start(queue: .main)
            }
            listener?.start(queue: .main)
        } catch {
            print("Failed to start listener: \(error)")
        }
    }

    // MARK: Recieve

    /**
     Receives data from a connection.

     - Parameter connection: The connection to receive data from.
     */
    private func receive(on connection: NWConnection) {
        connection.receiveMessage { data, _, isComplete, error in
            if let data = data, !data.isEmpty {
                if let packet = self.decodePacket(data: data) {
                    self.packetHandler?(packet)
                }
            }
            if isComplete {
                connection.cancel()
            } else if let error = error {
                print("Receive error: \(error)")
            } else {
                self.receive(on: connection)
            }
        }
    }

    // MARK: Decode Packet

    /**
     Decodes the received data into a `RoveCommPacket`.

     - Parameter data: The data to decode.
     - Returns: A `RoveCommPacket` if decoding is successful, otherwise `nil`.
     */
    private func decodePacket(data: Data) -> RoveCommPacket? {
        guard data.count >= 6 else {
            print("Data too short to decode")
            return nil
        }

        let header = RoveCommHeader(
            version: data[0],
            data_id: UInt16(data[1]) << 8 | UInt16(data[2]),
            data_count: UInt16(data[3]) << 8 | UInt16(data[4]),
            data_type: data[5]
        )

        let payloadData = Array(data[6 ..< data.count])
        return RoveCommPacket(header: header, data: payloadData)
    }

    // MARK: Stop Listener

    /**
     Stops the listener.
     */
    func stopListening() {
        listener?.cancel()
        listener = nil
    }
}
