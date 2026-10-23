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
            url: "https://github.com/Buoy-gg/Buoy-Swift/releases/download/0.1.11/Buoy-0.1.11.xcframework.zip",
            checksum: "b44595f3eeee5fbc4c22bd90ba242e4002582d65dffab79c06474351a3955226"
        ),
    ]
)
