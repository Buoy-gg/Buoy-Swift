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
            url: "https://github.com/Buoy-gg/Buoy-Swift/releases/download/0.1.14/Buoy-0.1.14.xcframework.zip",
            checksum: "92f5437ab778c7c355c0867db0ea6450303e799ba7e737e740c29697557a0555"
        ),
    ]
)
