// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-memory-shared-primitives",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Memory Shared Primitives",
            targets: ["Memory Shared Primitives"]
        ),
        .library(
            name: "Memory Shared Primitives Test Support",
            targets: ["Memory Shared Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-primitives/swift-memory-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-error-primitives.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Memory Shared Primitives",
            dependencies: [
                .product(name: "Memory Primitive", package: "swift-memory-primitives"),
                .product(name: "Error Primitives", package: "swift-error-primitives"),
            ]
        ),
        .target(
            name: "Memory Shared Primitives Test Support",
            dependencies: [
                "Memory Shared Primitives",
                .product(
                    name: "Memory Primitives Test Support",
                    package: "swift-memory-primitives"
                ),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Memory Shared Primitives Tests",
            dependencies: [
                "Memory Shared Primitives"
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = [
        .enableExperimentalFeature("RawLayout")
    ]

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
