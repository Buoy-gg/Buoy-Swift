// swift-tools-version: 5.9
// Buoy for native iOS, distributed as a signed binary framework.
import PackageDescription

let package = Package(
    name: "Buoy",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "Buoy", targets: ["Buoy"]),
    ],
    targets: [
        .binaryTarget(
            name: "Buoy",
            url: "https://github.com/Buoy-gg/Buoy-Swift/releases/download/0.1.12/Buoy-0.1.12.xcframework.zip",
            checksum: "9a4e9815a7419e881b19ac324b9e790372488968f83eac788f6d96e377d870d5"
        ),
    ]
)
