// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SpotIMCore",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "SpotIMCore", targets: ["WrapperSPMTarget"])
    ],
    dependencies: [
        // Here we define our package's external dependencies
        // and from where they can be fetched:
        .package(
            url: "https://github.com/ReactiveX/RxSwift.git",
            .upToNextMinor(from: "6.5.0")
        )
    ],
    targets: [
        .target(
            name: "WrapperSPMTarget",
            dependencies: ["RxSwift", "RxCocoa"]),
        .target(name: "SpotImCore", condition: .when(platforms: .some([.iOS]))),
        .binaryTarget(
            name: "WrapperSPMTarget",
            path: "SpotImCore.xcframework"
        )
    ]
)

