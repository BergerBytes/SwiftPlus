// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Swift+",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_13),
        .watchOS(.v4),
        .tvOS(.v11),
    ],
    products: [
        .library(
            name: "SwiftPlus",
            targets: ["SwiftPlus"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "7.0.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "12.0.0"),
        .package(url: "https://github.com/apple/swift-algorithms.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "SwiftPlus",
            dependencies: [.product(name: "Algorithms", package: "swift-algorithms")]
        ),
        .testTarget(
            name: "SwiftPlusTests",
            dependencies: ["SwiftPlus", "Quick", "Nimble"]
        ),
    ]
)
