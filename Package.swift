// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "HoneyRL",
    products: [
        .library(
            name: "HoneyRL",
            targets: ["HoneyRL"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pumperknickle/Bedrock.git", from: "0.1.2"),
        .package(url: "https://github.com/pumperknickle/AwesomeDictionary.git", from: "0.0.3"),
        .package(url: "https://github.com/pumperknickle/AwesomeTrie.git", from: "0.0.7"),
        .package(url: "https://github.com/Quick/Quick.git", from: "2.1.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "8.0.2"),
    ],
    targets: [
        .target(
            name: "HoneyRL",
            dependencies: ["Bedrock", "AwesomeDictionary"]),
        .testTarget(
            name: "HoneyRLTests",
            dependencies: ["HoneyRL", "Quick", "Nimble", "AwesomeTrie"]),
    ]
)
