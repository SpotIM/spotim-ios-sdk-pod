# Spot.IM SDK for iOS 🚀

This library provides an easy integration with Spot.IM into a native iOS app.

## Requirements

* iOS 10.3 or later.
* Have a [Spot.IM](https://spot.im) account

## Getting started

### Add the SDK to your project

#### Using [CocoaPods](https://cocoapods.org)
1. Set dependency as follows:
    `pod 'SpotIMCore', '1.6.9'`
2. Execute `pod install` in Terminal
3. Open workspace file and run

#### Using [Swift Package Manager](https://swift.org/package-manager)
The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into the swift compiler.
Once you have your Swift package set up, adding SpotIM as a dependency is as easy as adding it to the dependencies value of your Package.swift.
```
dependencies: [
    .package(url: "https://github.com/SpotIM/spotim-ios-sdk-pod.git", .upToNextMajor(from: "1.6.9"))
]
```

### Follow The Official Documentation

Please follow [the official OpenWeb iOS SDK documentation](https://developers.openweb.com/docs/ios-getting-started).
