// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TestSupport",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TestSupport",
            targets: ["TestSupport"]
        ),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../GarminKit")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "TestSupport",
            dependencies: [
                .product(
                    name: "Domain",
                    package: "Domain"
                ),
                .product(
                    name: "GarminKit",
                    package: "GarminKit"
                )
            ]
        ),
        .testTarget(
            name: "TestSupportTests",
            dependencies: ["TestSupport"]
        ),
    ]
)
