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
            url: "https://github.com/Buoy-gg/Buoy-Swift/releases/download/0.1.2/Buoy-0.1.2.xcframework.zip",
            checksum: "75c148efa1e5dd2a98bddaec87ef42b6f06f66b628b69aea84caec1e5dc8a1b8"
        ),
    ]
)
