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
            url: "https://github.com/Buoy-gg/Buoy-Swift/releases/download/0.1.15/Buoy-0.1.15.xcframework.zip",
            checksum: "27f49cab15fc4558aa883a2238cabf3a18be1a206de77e24e036221ba53694cf"
        ),
    ]
)
