// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SpotIMCore",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "SpotIMCore", targets: ["WrapperSPMTarget"])
    ],
    dependencies: [
        // Here we define our package's external dependencies
        // and from where they can be fetched:
        .package(
            url: "https://github.com/Alamofire/Alamofire",
            .exact("5.2.0")
        ),
        .package(
            url: "https://github.com/mxcl/PromiseKit",
            .exact("6.8.0")
        ),
        .package(
            url: "https://github.com/ReactiveX/RxSwift.git",
            .exact("6.5.0")
        )
    ],
    targets: [
        .binaryTarget(
            name: "SpotIMCoreXCFramework",
            path: "SpotImCore.xcframework"
        ),
        .target(
            name: "WrapperSPMTarget",
            dependencies: [
                .target(name: "SpotIMCoreXCFramework", condition: .when(platforms: .some([.iOS]))),
                "Alamofire",
                "PromiseKit",
                "RxSwift",
                "RxCocoa"
            ]
        )
    ]
)
