// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "NotchShelf",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "NotchShelf", targets: ["NotchShelf"])
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "NotchShelf",
            dependencies: [],
            path: "NotchShelf/Sources"
        )
    ]
)
