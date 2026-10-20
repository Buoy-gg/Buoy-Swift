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
            url: "https://github.com/Buoy-gg/Buoy-Swift/releases/download/0.1.6/Buoy-0.1.6.xcframework.zip",
            checksum: "a18d669527f997e520626a38dfd80e3d529f731fe708146212d4a1605cc59b4c"
        ),
    ]
)
