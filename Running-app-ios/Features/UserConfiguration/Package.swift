// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UserConfiguration",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UserConfiguration",
            targets: ["UserConfiguration"]
        ),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Common"),
        .package(path: "../Application"),
        .package(path: "../Localization"),
        .package(path: "../TestSupport")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UserConfiguration",
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
        ),
        .testTarget(
            name: "UserConfigurationTests",
            dependencies: [
                "UserConfiguration",
                .product(
                    name: "TestSupport",
                    package: "TestSupport"
                )
            ]
        ),
    ]
)
