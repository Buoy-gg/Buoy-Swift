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
            url: "https://github.com/Buoy-gg/Buoy-Swift/releases/download/0.1.3/Buoy-0.1.3.xcframework.zip",
            checksum: "fa4558d76ac57c93af385ef6115040a1677ad5ef1ba7213174aa20d7e1586b57"
        ),
    ]
)
