// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GarminKit",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "GarminKit",
            targets: ["GarminKit"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/garmin/fit-swift-sdk.git",
            exact: "21.187.0"
        ),
        .package(path: "../Domain")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "GarminKit",
            dependencies: [
                .product(
                    name: "FITSwiftSDK",
                    package: "fit-swift-sdk"
                ),
                .product(
                    name: "Domain",
                    package: "Domain"
                )
            ]
        ),
        .testTarget(
            name: "GarminKitTests",
            dependencies: ["GarminKit"],
            resources: [
                .process("Fixtures")
            ]
        ),
    ]
)
