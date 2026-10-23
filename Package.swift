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
            url: "https://github.com/Buoy-gg/Buoy-Swift/releases/download/0.1.10/Buoy-0.1.10.xcframework.zip",
            checksum: "8d0d80edba97e110aa2329c435510a58bf471d85e302918f7fa126f8d62e0ce3"
        ),
    ]
)
