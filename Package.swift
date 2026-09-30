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
            url: "https://github.com/Buoy-gg/Buoy-Swift/releases/download/0.1.0/Buoy-0.1.0.xcframework.zip",
            checksum: "3c3b2ff5d0fcf93fced95e8f936f30e03f0510e806b9820f65119d8128c0b069"
        ),
    ]
)
