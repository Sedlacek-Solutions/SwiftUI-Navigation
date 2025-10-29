// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUI-Navigation",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9)
    ],
    products: [
        .library(
            name: "Navigation",
            targets: ["Navigation"]
        ),
        .executable(
            name: "ExampleApp",
            targets: ["ExampleApp"]
        )
    ],
    targets: [
        .target(name: "Navigation"),
        .executableTarget(
            name: "ExampleApp",
            dependencies: ["Navigation"],
            path: "ExampleApp"
        ),
        .testTarget(
            name: "SwiftUINavigationTests",
            dependencies: ["Navigation"]
        ),
    ]
)
