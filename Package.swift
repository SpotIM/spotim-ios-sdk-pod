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
        .library(name: "SpotIMCore", targets: ["SpotIMCore"])
    ],
    dependencies: [
        // Here we define our package's external dependencies
        // and from where they can be fetched:
        .package(
            url: "https://github.com/Alamofire/Alamofire",
            .upToNextMinor(from: "5.2.0")
        ),
        .package(
            url: "https://github.com/mxcl/PromiseKit",
            .upToNextMinor(from: "6.8.0")
        )
    ],
    targets: [
        .binaryTarget(
            name: "SpotIMCoreXCFramework",
            path: "SpotImCore.xcframework"
        ),
        .target(
            name: "DummyTarget",
            dependencies: [
                .target(name: "SpotIMCoreXCFramework", condition: .when(platforms: .some([.iOS]))),
                "Alamofire",
                "PromiseKit"
            ]
        )
    ]
)
