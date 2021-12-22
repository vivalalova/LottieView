// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LottieView",
    platforms: [
        .iOS(SupportedPlatform.IOSVersion.v12),
        .macOS(SupportedPlatform.MacOSVersion.v10_12)
    ],
    products: [
        .library(name: "LottieView", targets: ["LottieView"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Lottie", url: "git@github.com:airbnb/lottie-ios.git", from: Version(3, 3, 0))
    ],
    targets: [
        .target(
            name: "LottieView",
            dependencies: ["Lottie"]
        )
    ]
)
