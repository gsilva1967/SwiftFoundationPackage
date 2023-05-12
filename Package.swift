// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftFoundationPackage",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DateExtensions",
            targets: ["DateExtensions"]),
        .library(
            name: "StringExtensions",
            targets: ["StringExtensions"]),
        .library(
            name: "SwiftUIHelpers",
            targets: ["SwiftUIHelpers"]),
        .library(
            name: "IntExtensions",
            targets: ["IntExtensions"]),
        .library(
            name: "DoubleExtensions",
            targets: ["DoubleExtensions"]),
        .library(
            name: "SwiftFoundationPackage",
            targets: ["SwiftFoundationPackage"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DateExtensions",
            dependencies: []),
        .target(
            name: "StringExtensions",
            dependencies: []),
        .target(
            name: "SwiftUIHelpers",
            dependencies: []),
        .target(
            name: "IntExtensions",
            dependencies: []),
        .target(
            name: "DoubleExtensions",
            dependencies: []),
        .target(
            name: "SwiftFoundationPackage",
            dependencies: []),
//        .testTarget(
//            name: "SwiftFoundationPackageTests",
//            dependencies: ["SwiftFoundationPackage"]),
    ]
)
