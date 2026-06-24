// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "fk_user_agent",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "fk-user-agent", targets: ["fk_user_agent"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "fk_user_agent",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ],
            cSettings: [
                .headerSearchPath("include/fk_user_agent")
            ]
        )
    ]
)
