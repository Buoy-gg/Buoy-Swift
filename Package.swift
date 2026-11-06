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
            url: "https://github.com/Buoy-gg/Buoy-Swift/releases/download/0.1.13/Buoy-0.1.13.xcframework.zip",
            checksum: "01ebf49efb9079af1b3dbafed97ebeb9bd821c91aded4fdc0a6425d344e6b3aa"
        ),
    ]
)
