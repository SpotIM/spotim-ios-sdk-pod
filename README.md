# Spot.IM SDK for iOS 🚀

This library provides an easy integration with Spot.IM into a native iOS app.

## Requirements

* iOS 10.3 or later.
* Have a [Spot.IM](https://spot.im) account

## Getting started

### Add the SDK to your project

#### Using [CocoaPods](https://cocoapods.org)
1. Set dependency as follows:
    `pod 'SpotIMCore', '1.5.7'`
2. Execute `pod install` in Terminal
3. Open workspace file and run

### How To Release From a "git tag"?

1. create a new branch `3.4.3-custom-release`

2. In the new branch: A) Copy the new XCFramework. B) edit podspec file (keep "version" as is, change the `s.source` with the new tag (3.4.3-custom-release):

```
s.source = { :git => 'https://github.com/SpotIM/spotim-ios-sdk-pod.git', :tag => "3.4.3-custom-release" }
```

4. git commit (on podspec file and new XCFramework)

5. git tag 3.4.3-custom-release

6. git push origin --tags

7. Developers should integrate via:

```
pod 'SpotIMCore', :git => 'https://github.com/SpotIM/spotim-ios-sdk-pod.git', :tag => '3.4.3-custom-release'
```


### Follow The Official Documentation

Please follow [the official OpenWeb iOS SDK documentation](https://developers.openweb.com/docs/ios-getting-started).
