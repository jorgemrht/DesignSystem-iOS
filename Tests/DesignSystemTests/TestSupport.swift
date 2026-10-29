import JDesignSystem
import SwiftUI

func rgba(_ color: Color, in colorScheme: ColorScheme = .light, theme: DSTheme = .default) -> [Float] {
  var environment = EnvironmentValues()
  environment.colorScheme = colorScheme
  environment.dsTheme = theme
  let resolved = color.resolve(in: environment)
  return [resolved.red, resolved.green, resolved.blue, resolved.opacity]
}

func isClose(_ lhs: [Float], _ rhs: [Float], tolerance: Float = 0.004) -> Bool {
  lhs.count == rhs.count && zip(lhs, rhs).allSatisfy { abs($0 - $1) <= tolerance }
}

extension DSColorTheme {
  static func uniform(_ color: Color, primary: Color? = nil) -> DSColorTheme {
    DSColorTheme(
      primary: primary ?? color,
      onPrimary: color,
      primaryContainer: color,
      onPrimaryContainer: color,
      inversePrimary: color,
      secondary: color,
      onSecondary: color,
      secondaryContainer: color,
      onSecondaryContainer: color,
      tertiary: color,
      onTertiary: color,
      tertiaryContainer: color,
      onTertiaryContainer: color,
      background: color,
      onBackground: color,
      surface: color,
      onSurface: color,
      surfaceVariant: color,
      onSurfaceVariant: color,
      surfaceTint: color,
      inverseSurface: color,
      inverseOnSurface: color,
      error: color,
      onError: color,
      errorContainer: color,
      onErrorContainer: color,
      outline: color,
      outlineVariant: color,
      scrim: color
    )
  }
}

extension DSButtonAppearance {
  nonisolated static let testTertiaryContainer = DSButtonAppearance(
    foreground: .dsOnTertiaryContainer,
    background: .dsTertiaryContainer,
    pressedOverlay: .dsOnTertiaryContainer,
    disabledForeground: .dsOnTertiaryContainer.opacity(0.55),
    disabledBackground: .dsTertiaryContainer.opacity(0.38)
  )

  nonisolated static let testPrimaryContainer = DSButtonAppearance(
    foreground: .dsOnPrimaryContainer,
    background: .dsPrimaryContainer,
    pressedOverlay: .dsOnPrimaryContainer,
    disabledForeground: .dsOnPrimaryContainer.opacity(0.55),
    disabledBackground: .dsPrimaryContainer.opacity(0.38)
  )

  nonisolated static let testErrorOutline = DSButtonAppearance(
    foreground: .dsError,
    background: nil,
    border: .dsError,
    pressedOverlay: .dsError,
    disabledForeground: .dsError.opacity(0.38),
    disabledBackground: nil,
    disabledBorder: .dsError.opacity(0.24)
  )

  nonisolated static let testErrorText = DSButtonAppearance(
    foreground: .dsError,
    background: nil,
    pressedOverlay: .dsError,
    disabledForeground: .dsError.opacity(0.38),
    disabledBackground: nil
  )
}

extension DSSystemSymbol {
  nonisolated static let testSearch = Self("magnifyingglass")
  nonisolated static let testClose = Self("xmark")
  nonisolated static let testStar = Self("star")
  nonisolated static let testMoon = Self("moon")
  nonisolated static let testUpdate = Self("arrow.down.app")
}
