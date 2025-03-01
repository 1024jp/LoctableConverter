// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "LoctableConverter",
    platforms: [
        .macOS(.v13),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
    ],
    targets: [
        .executableTarget(
            name: "Convert",
            dependencies: [
                "LoctableConverter",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
        .target(name: "LoctableConverter"),
    ]
)


for target in package.targets {
    target.swiftSettings = [
        .enableUpcomingFeature("ExistentialAny"),
    ]
}
