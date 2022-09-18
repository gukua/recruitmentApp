// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "AudiotekaDomain",
    platforms: [
        .iOS(.v13),
        .macOS(.v11)
        ],
    products: [
        .library(
            name: "AudiotekaDomain",
            targets: ["AudiotekaDomain"]),
    ],
    dependencies: [
        .package(name: "DummyApiService", path: "../DummyApiService"),
    ],
    targets: [
        .target(
            name: "AudiotekaDomain",
            dependencies: ["DummyApiService"]),
        .testTarget(
            name: "AudiotekaDomainTests",
            dependencies: ["AudiotekaDomain"]),
    ]
)
