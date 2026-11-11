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
            url: "https://github.com/Buoy-gg/Buoy-Swift/releases/download/0.1.16/Buoy-0.1.16.xcframework.zip",
            checksum: "87f8ee67456f4554a9d24ba3b80db3105a8deab74f731f05a69f514f4ccf58b4"
        ),
    ]
)
