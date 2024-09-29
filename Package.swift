// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ContractBridgeUI",
    platforms: [
        .macOS(.v10_15), .iOS(.v13)
    ],
    products: [
        .library(
            name: "ContractBridgeUI",
            targets: ["ContractBridgeUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/RalphLipe/ContractBridge", .branch("matchpoints"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ContractBridgeUI",
            dependencies: [ "ContractBridge" ]),
        .testTarget(
            name: "ContractBridgeUITests",
            dependencies: ["ContractBridgeUI"]),
    ]
)
