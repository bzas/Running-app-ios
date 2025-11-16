// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Application",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Application",
            targets: ["Application"]
        ),
    ],
    dependencies: [
        .package(path: "../GarminKit"),
        .package(path: "../Database"),
        .package(path: "../Domain")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Application",
            dependencies: [
                .product(
                    name: "GarminKit",
                    package: "GarminKit"
                ),
                .product(
                    name: "Database",
                    package: "Database"
                ),
                .product(
                    name: "Domain",
                    package: "Domain"
                )
            ]
        ),
        .testTarget(
            name: "ApplicationTests",
            dependencies: ["Application"]
        ),
    ]
)
