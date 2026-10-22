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
            url: "https://github.com/Buoy-gg/Buoy-Swift/releases/download/0.1.9/Buoy-0.1.9.xcframework.zip",
            checksum: "2c9d68d8055c58cb56549876c9c299eb86a110b57e52f464e34f953066452875"
        ),
    ]
)
