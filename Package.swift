// swift-tools-version:6.1
import PackageDescription

let package = Package(
  name: "DesignSystem",
  platforms: [
    .iOS(.v17), .macOS(.v14), .tvOS(.v17), .watchOS(.v10)
  ],
  products: [
    .library(
      name: "DesignSystem",
      targets: ["DesignSystem"]
    ),
  ],
  targets: [
    .target(
      name: "DesignSystem",
      path: "Sources/DesignSystem",
      resources: [.process("Theme/Resources")]
    ),
    .testTarget(
      name: "DesignSystemTests",
      dependencies: ["DesignSystem"]
    ),
  ]
)
