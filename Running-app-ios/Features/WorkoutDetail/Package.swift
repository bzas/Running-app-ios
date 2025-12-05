// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WorkoutDetail",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "WorkoutDetail",
            targets: ["WorkoutDetail"]
        ),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Application"),
        .package(path: "../Common"),
        .package(path: "../Localization"),
        .package(path: "../TestSupport")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "WorkoutDetail",
            dependencies: [
                .product(
                    name: "Domain",
                    package: "Domain"
                ),
                .product(
                    name: "Common",
                    package: "Common"
                ),
                .product(
                    name: "Localization",
                    package: "Localization"
                ),
                .product(
                    name: "Application",
                    package: "Application"
                )
            ]
        ),
        .testTarget(
            name: "WorkoutDetailTests",
            dependencies: [
                "WorkoutDetail",
                .product(
                    name: "TestSupport",
                    package: "TestSupport"
                )
            ]
        ),
    ]
)
