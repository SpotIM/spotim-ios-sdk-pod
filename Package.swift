// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SpotIMCore",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "SpotIMCore", targets: ["SpotIMCore"])
    ],
    targets: [
        .binaryTarget(
            name: "SpotIMCore",
            path: "SpotImCore.xcframework"
        )
    ]
)
