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
            url: "https://github.com/Buoy-gg/Buoy-Swift/releases/download/0.1.8/Buoy-0.1.8.xcframework.zip",
            checksum: "0ef732a742ea19a59bfbb22fbf713971e1d36918419343be384eb7fdeaa708ca"
        ),
    ]
)
