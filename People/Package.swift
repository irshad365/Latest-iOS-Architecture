// swift-tools-version: 5.10.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "People",
    platforms: [
        .iOS(.v17),
        .macOS(.v12)
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
                .product(name: "Core", package: "Core"),
                .product(name: "SwiftUICore", package: "SwiftUICore")
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
