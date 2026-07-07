import SwiftUI
import Testing
@testable import DesignSystem

@Test
func fontSizeTextStyleMappingIsCorrect() async throws {
  let expected: [(FontSize, Font.TextStyle)] = [
    (.largeTitle, .largeTitle),
    (.title,     .title),
    (.title2,     .title2),
    (.title3,     .title3),
    (.headline,   .headline),
    (.body,       .body),
    (.callout,    .callout),
    (.subheadline, .subheadline),
    (.footnote,   .footnote),
    (.caption1,   .caption),
    (.caption2,   .caption2)
  ]

  for (fontSize, expectedStyle) in expected {
    #expect(fontSize.textStyle == expectedStyle, "Expected \(fontSize.rawValue) to map to \(expectedStyle), got \(fontSize.textStyle)")
  }
}

@Test
func material3ColorAssetsExist() async throws {
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
    "dsScrim",
    "dsSurfaceBright",
    "dsSurfaceDim",
    "dsSurfaceContainer",
    "dsSurfaceContainerHigh",
    "dsSurfaceContainerHighest",
    "dsSurfaceContainerLow",
    "dsSurfaceContainerLowest",
    "dsPrimaryFixed",
    "dsPrimaryFixedDim",
    "dsOnPrimaryFixed",
    "dsOnPrimaryFixedVariant",
    "dsSecondaryFixed",
    "dsSecondaryFixedDim",
    "dsOnSecondaryFixed",
    "dsOnSecondaryFixedVariant",
    "dsTertiaryFixed",
    "dsTertiaryFixedDim",
    "dsOnTertiaryFixed",
    "dsOnTertiaryFixedVariant"
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
func defaultThemeExposesMaterial3CoreColorRoles() async throws {
  let colors = DSTheme.default.colors

  _ = colors.primary
  _ = colors.onPrimary
  _ = colors.primaryContainer
  _ = colors.onPrimaryContainer
  _ = colors.secondary
  _ = colors.onSecondary
  _ = colors.secondaryContainer
  _ = colors.onSecondaryContainer
  _ = colors.background
  _ = colors.onBackground
  _ = colors.surface
  _ = colors.onSurface
  _ = colors.surfaceVariant
  _ = colors.onSurfaceVariant
  _ = colors.outline
  _ = colors.outlineVariant
  _ = colors.error
  _ = colors.onError
}
