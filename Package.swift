// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "PascalCompilerSwift",
    
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    
    products: [
        .library(
            name: "PascalKit",
            targets: ["PascalKit"]
        ),
    ],
    
    targets: [
        .target(
            name: "PascalKit",
            dependencies: [],
            path: "Sources/PascalKit"
        ),
        .testTarget(
            name: "PascalKitTests",
            dependencies: ["PascalKit"],
            path: "Tests/PascalKitTests"
        ),
    ],
    
    swiftLanguageVersions: [
        .v6
    ]
)
