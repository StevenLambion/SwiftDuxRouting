// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftDuxRouting",
    platforms: [
      .iOS(.v13),
      .macOS(.v10_15),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SwiftDuxRouting",
            targets: ["SwiftDuxRouting"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
      .package(url: "https://github.com/StevenLambion/SwiftDux.git", .branch("master")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SwiftDuxRouting",
            dependencies: ["SwiftDux"]),
        .testTarget(
            name: "SwiftDuxRoutingTests",
            dependencies: ["SwiftDuxRouting"]),
    ]
)
