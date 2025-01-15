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
        .package(path: "../Core"),
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.58.0")
    ],
    targets: [
        .target(
            name: "People",
            dependencies: [
                .product(name: "Core", package: "Core")
            ],
            resources: [
                .process("Mock/people.json"),
            ],
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
            ]
        ),
        .testTarget(
            name: "PeopleTests",
            dependencies: ["People"]
        ),
    ]
)
