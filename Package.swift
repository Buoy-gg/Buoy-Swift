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
            url: "https://github.com/Buoy-gg/Buoy-Swift/releases/download/0.1.1/Buoy-0.1.1.xcframework.zip",
            checksum: "d85331b9786992d48c36e06250d4b490323ebd5c60612222426069b9ba141f10"
        ),
    ]
)
