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
            url: "https://github.com/Buoy-gg/Buoy-Swift/releases/download/0.1.17/Buoy-0.1.17.xcframework.zip",
            checksum: "dacd928890759146ac555291d9ff1a9ec4aa6a06c37d4e2cf6afcf2eb002105d"
        ),
    ]
)
