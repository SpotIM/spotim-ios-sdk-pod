// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SpotIMCore",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    products: [
        .library(name: "SpotIMCore", targets: ["SpotIMCoreXCFramework"])
    ],
    targets: [
        .binaryTarget(
            name: "SpotIMCoreXCFramework",
            path: "SpotImCore.xcframework"
        )
    ]
)
