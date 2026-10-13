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
            url: "https://github.com/Buoy-gg/Buoy-Swift/releases/download/0.1.5/Buoy-0.1.5.xcframework.zip",
            checksum: "f49ecbf694fffd445c2552e5dc911a3c485c954571fdbb02763f6fd6e931d70d"
        ),
    ]
)
