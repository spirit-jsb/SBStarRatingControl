// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "SBStarRatingControl",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(name: "SBStarRatingControl", targets: ["SBStarRatingControl"]),
    ],
    targets: [
        .target(name: "SBStarRatingControl", path: "Sources"),
    ],
    swiftLanguageVersions: [
        .v5,
    ]
)
