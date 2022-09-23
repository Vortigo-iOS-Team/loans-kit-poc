// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoansKit",
    products: [
        .library(
            name: "LoansKit",
            targets: ["LoansKit"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "LoansKit",
            dependencies: []),
        .testTarget(
            name: "LoansKitTests",
            dependencies: ["LoansKit"]),
    ]
)
