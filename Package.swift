// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SpotIMCore",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "SpotIMCore", targets: ["SpotImWrapperSPMTarget"])
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
        .binaryTarget(
            name: "SpotImCore",
            path: "SpotImCore.xcframework"
        ),
        .target(
            name: "SpotImWrapperSPMTarget",
            dependencies: [
                .target(name: "SpotImCore", condition: .when(platforms: .some([.iOS]))),
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift")
            ]
        )
    ]
)
