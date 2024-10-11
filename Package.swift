// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JuspayKit",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "JuspayKit",
            targets: ["JuspayKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.23.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", "1.0.0" ..< "4.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "JuspayKit", dependencies: [
            .product(name: "AsyncHTTPClient", package: "async-http-client"),
            .product(name: "Crypto", package: "swift-crypto"),
            ],
            swiftSettings: swiftSettings),
        .testTarget(
            name: "JuspayKitTests",
            dependencies: ["JuspayKit"]),
    ]
)

var swiftSettings: [SwiftSetting] {
    [
        .enableUpcomingFeature("StrictConcurrency"),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("FullTypedThrows"),
    ]
}
