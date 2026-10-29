import Foundation
@testable import JDesignSystem
import SwiftUI
import Testing

@Test
func `material 3 color assets exist`() throws {
  let expectedNames = [
    "dsPrimary",
    "dsOnPrimary",
    "dsPrimaryContainer",
    "dsOnPrimaryContainer",
    "dsInversePrimary",
    "dsSecondary",
    "dsOnSecondary",
    "dsSecondaryContainer",
    "dsOnSecondaryContainer",
    "dsTertiary",
    "dsOnTertiary",
    "dsTertiaryContainer",
    "dsOnTertiaryContainer",
    "dsBackground",
    "dsOnBackground",
    "dsSurface",
    "dsOnSurface",
    "dsSurfaceVariant",
    "dsOnSurfaceVariant",
    "dsSurfaceTint",
    "dsInverseSurface",
    "dsInverseOnSurface",
    "dsError",
    "dsOnError",
    "dsErrorContainer",
    "dsOnErrorContainer",
    "dsOutline",
    "dsOutlineVariant",
    "dsScrim"
  ]

  let testFileURL = URL(fileURLWithPath: #filePath)
  let packageURL = testFileURL
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .deletingLastPathComponent()
  let assetCatalogURL = packageURL
    .appendingPathComponent("Sources/DesignSystem/Theme/Resources/Colors.xcassets")

  for name in expectedNames {
    let contentsURL = assetCatalogURL
      .appendingPathComponent("\(name).colorset")
      .appendingPathComponent("Contents.json")
    #expect(FileManager.default.fileExists(atPath: contentsURL.path))

    let data = try Data(contentsOf: contentsURL)
    let json = try #require(try JSONSerialization.jsonObject(with: data) as? [String: Any])
    let colors = try #require(json["colors"] as? [[String: Any]])
    #expect(colors.count == 2)

    let hasLightColor = colors.contains { color in
      color["color"] != nil && color["appearances"] == nil
    }
    let hasDarkColor = colors.contains { color in
      guard let appearances = color["appearances"] as? [[String: Any]] else {
        return false
      }

      return appearances.contains { appearance in
        appearance["appearance"] as? String == "luminosity"
          && appearance["value"] as? String == "dark"
      }
    }

    #expect(hasLightColor)
    #expect(hasDarkColor)
  }
}

@Test
func `default theme exposes material 3 core color roles`() {
  let colors = DSTheme.default.colors

  _ = colors.primary
  _ = colors.onPrimary
  _ = colors.primaryContainer
  _ = colors.onPrimaryContainer
  _ = colors.inversePrimary
  _ = colors.secondary
  _ = colors.onSecondary
  _ = colors.secondaryContainer
  _ = colors.onSecondaryContainer
  _ = colors.tertiary
  _ = colors.onTertiary
  _ = colors.tertiaryContainer
  _ = colors.onTertiaryContainer
  _ = colors.background
  _ = colors.onBackground
  _ = colors.surface
  _ = colors.onSurface
  _ = colors.surfaceVariant
  _ = colors.onSurfaceVariant
  _ = colors.surfaceTint
  _ = colors.inverseSurface
  _ = colors.inverseOnSurface
  _ = colors.outline
  _ = colors.outlineVariant
  _ = colors.error
  _ = colors.onError
  _ = colors.errorContainer
  _ = colors.onErrorContainer
  _ = colors.scrim
}
