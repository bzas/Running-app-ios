// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Profile",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Profile",
            targets: ["Profile"]
        ),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Application"),
        .package(path: "../Common"),
        .package(path: "../Localization"),
        .package(path: "../UserConfiguration"),
        .package(path: "../TestSupport")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Profile",
            dependencies: [
                .product(
                    name: "Domain",
                    package: "Domain"
                ),
                .product(
                    name: "Application",
                    package: "Application"
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
                    name: "UserConfiguration",
                    package: "UserConfiguration"
                )
            ]
        ),
        .testTarget(
            name: "ProfileTests",
            dependencies: [
                "Profile",
                .product(
                    name: "TestSupport",
                    package: "TestSupport"
                )
            ]
        ),
    ]
)
