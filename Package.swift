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
            url: "https://github.com/Buoy-gg/Buoy-Swift/releases/download/0.1.7/Buoy-0.1.7.xcframework.zip",
            checksum: "fc062a6e8754e99e71a9c12d2468375a67718dddacc36860743b8c5b6c167c3d"
        ),
    ]
)
