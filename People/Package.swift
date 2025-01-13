// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "People",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(
            name: "People",
            targets: ["People"]),
    ],
    dependencies: [
        .package(path: "../Core")
    ],
    targets: [
        .target(
            name: "People",
            dependencies: [
                .product(name: "Core", package: "Core")
            ],
            resources: [
                .process("Mock/people.json"),
            ]
        ),
        .testTarget(
            name: "PeopleTests",
            dependencies: ["People"]
        ),
    ]
)
