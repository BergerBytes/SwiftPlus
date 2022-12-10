// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Swift+",
    products: [
        .library(
            name: "SwiftPlus",
            targets: ["SwiftPlus"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "5.0.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "10.0.0"),
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
