// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Graph",
    products: [
        .library(
            name: "Graph",
            targets: ["Graph"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/reizu/swift-collections.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "Graph",
            dependencies: [
                "Collections",
            ]
        ),
        .testTarget(
            name: "GraphTests",
            dependencies: ["Graph"]
        ),
    ]
)
