// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftNetworkManager",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "SwiftNetworkManager",
            targets: ["SwiftNetworkManager"]),
    ],
    targets: [
        .target(
            name: "SwiftNetworkManager"),
        .testTarget(
            name: "SwiftNetworkManagerTests",
            dependencies: ["SwiftNetworkManager"]),
    ]
)
