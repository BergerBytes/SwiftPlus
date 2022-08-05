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
    dependencies: [],
    targets: [
        .target(
            name: "SwiftPlus",
            dependencies: []
        ),
        .testTarget(
            name: "SwiftPlusTests",
            dependencies: ["SwiftPlus"]
        ),
    ]
)
