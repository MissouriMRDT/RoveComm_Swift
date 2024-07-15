# RoveComm Swift

The `RoveComm` Swift package provides functionality for sending and receiving UDP packets over a network. It supports sending data in various types such as `UInt8`, `UInt16`, `UInt32`, `Int8`, `Int16`, `Int32`, `Float`, `Double`, and `Character`.

## Features

- Send UDP packets with various data types
- Receive and decode UDP packets
- Unit tests for verifying functionality

## Requirements

- Swift 5.3 or later
- macOS 10.14 or later

## Installation

### Swift Package Manager

To integrate `RoveComm` into your Xcode project using Swift Package Manager, add the following to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/MissouriMRDT/RoveComm_Swift.git", from: "1.0.0")
]
```

Then, add `RoveComm` as a dependency in your target:

```swift
.target(
    name: "YourTargetName",
    dependencies: ["RoveComm_Swift"]
)
```

## Usage

### Sending UDP Packets

You can send UDP packets with various data types using the `RoveComm` class:

```swift
import RoveComm

let roveComm = RoveComm()
let header = RoveCommHeader(version: 3, data_id: 1001, data_count: 1, data_type: 0)

// Sending UInt8 data
let dataUInt8: [UInt8] = [1, 2, 3]
roveComm.sendUDP("localhost", 11000, header, dataUInt8)

// Sending UInt16 data
let dataUInt16: [UInt16] = [1, 2, 3, 4, 5]
roveComm.sendUDP("localhost", 11000, header, dataUInt16)

// Sending UInt32 data
let dataUInt32: [UInt32] = [1, 2, 3, 4, 5]
roveComm.sendUDP("localhost", 11000, header, dataUInt32)

// Sending Int8 data
let dataInt8: [Int8] = [1, 2, 3, 4, 5]
roveComm.sendUDP("localhost", 11000, header, dataInt8)

// Sending Int16 data
let dataInt16: [Int16] = [1, 2, 3, 4, 5]
roveComm.sendUDP("localhost", 11000, header, dataInt16)

// Sending Int32 data
let dataInt32: [Int32] = [1, 2, 3, 4, 5]
roveComm.sendUDP("localhost", 11000, header, dataInt32)

// Sending Float data
let dataFloat: [Float] = [1.0, 2.0, 3.0, 4.0, 5.0]
roveComm.sendUDP("localhost", 11000, header, dataFloat)

// Sending Double data
let dataDouble: [Double] = [1.0, 2.0, 3.0, 4.0, 5.0]
roveComm.sendUDP("localhost", 11000, header, dataDouble)

// Sending Character data
let dataCharacter: [Character] = ["a", "b", "c", "d", "e"]
roveComm.sendUDP("localhost", 11000, header, dataCharacter)
```

### Receiving UDP Packets

You can receive and decode UDP packets using the `RoveCommListener` class:

```swift
import RoveComm

let listener = RoveCommListener(port: 11000)
listener.packetHandler = { packet in
    print("Received packet: \(packet)")
}
listener.startListening()

// Remember to stop listening when done
listener.stopListening()
```

## Unit Tests

The `RoveComm_SwiftTests` class contains unit tests for verifying the functionality of the `RoveComm` class. You can run these tests using Xcode or the Swift Package Manager.

### Running Tests with Xcode

1. Open your Xcode project.
2. Select the test scheme.
3. Press `Cmd+U` to run the tests.

### Running Tests with Swift Package Manager

```bash
swift test
```

## Contributing

1. Create a feature branch.
2. Commit your changes.
3. Push to the branch.
4. Create a new pull request.

## License

This project is licensed under the GPLv3 License. See the `LICENSE` file for details.

## Contact

For questions, issues, or suggestions, please open an issue on GitHub.

---

Feel free to customize the above content as per your project specifics and preferences.
