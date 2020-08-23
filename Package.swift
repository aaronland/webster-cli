// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "webster-cli",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0"),
        .package(url: "https://github.com/aaronland/swift-webster", .branch("master")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "webster-cli",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Webster", package: "swift-webster"),
            ]),
        .testTarget(
            name: "webster-cliTests",
            dependencies: ["webster-cli"]),
    ]
)

/*
 /Users/asc/code/webster-cli/Package.swift: dependency 'Webster' in target 'webster-cli' requires explicit declaration; provide the name of the package dependency with '.package(name: "Webster", url: "https://github.com/aaronland/swift-webster", .branch("master"))'
 */
