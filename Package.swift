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
            url: "https://github.com/Buoy-gg/Buoy-Swift/releases/download/0.1.4/Buoy-0.1.4.xcframework.zip",
            checksum: "969d1729579caa5afae64b61873a30c277f11ebd28ea9a4d81b31bf2443d8d2c"
        ),
    ]
)
