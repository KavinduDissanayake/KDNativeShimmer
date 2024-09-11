// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "KDNativeShimmer",
    platforms: [
        .iOS(.v15) // Support for iOS 15 and above
    ],
    products: [
        .library(
            name: "KDNativeShimmer",
            targets: ["KDNativeShimmer"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "KDNativeShimmer",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "KDNativeShimmerTests",
            dependencies: ["KDNativeShimmer"],
            path: "Tests"
        )
    ],
    swiftLanguageVersions: [.v5] // This ensures compatibility with Swift 5.x versions
)
