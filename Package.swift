// swift-tools-version:6.3
import PackageDescription

let package = Package(
  name: "JDesignSystem",
  platforms: [
    .iOS(.v26),
    .macOS(.v26),
    .macCatalyst(.v26),
    .tvOS(.v26),
    .watchOS(.v26),
    .visionOS(.v26)
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
