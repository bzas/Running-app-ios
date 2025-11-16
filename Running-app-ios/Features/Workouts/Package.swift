// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Workouts",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Workouts",
            targets: ["Workouts"]
        ),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Common"),
        .package(path: "../Application"),
        .package(path: "../Localization")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Workouts",
            dependencies: [
                .product(
                    name: "Domain",
                    package: "Domain"
                ),
                .product(
                    name: "Localization",
                    package: "Localization"
                ),
                .product(
                    name: "Common",
                    package: "Common"
                ),
                .product(
                    name: "Application",
                    package: "Application"
                )
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "WorkoutsTests",
            dependencies: ["Workouts"]
        ),
    ]
)
