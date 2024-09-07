// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "KDNativeShimmer",
    platforms: [
        .iOS(.v15),  // Ensure you're targeting iOS 15 or higher
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
    ]
)
