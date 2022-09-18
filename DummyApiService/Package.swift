// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "DummyApiService",
    products: [
        .library(
            name: "DummyApiService",
            targets: ["DummyApiService"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DummyApiService",
            dependencies: [])
    ]
)
