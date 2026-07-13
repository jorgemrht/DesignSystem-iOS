import SwiftUI

public struct DSColorTheme: Sendable {
  public let primary: Color
  public let onPrimary: Color
  public let primaryContainer: Color
  public let onPrimaryContainer: Color
  public let inversePrimary: Color

  public let secondary: Color
  public let onSecondary: Color
  public let secondaryContainer: Color
  public let onSecondaryContainer: Color

  public let tertiary: Color
  public let onTertiary: Color
  public let tertiaryContainer: Color
  public let onTertiaryContainer: Color

  public let background: Color
  public let onBackground: Color

  public let surface: Color
  public let onSurface: Color
  public let surfaceVariant: Color
  public let onSurfaceVariant: Color
  public let surfaceTint: Color

  public let inverseSurface: Color
  public let inverseOnSurface: Color

  public let error: Color
  public let onError: Color
  public let errorContainer: Color
  public let onErrorContainer: Color

  public let outline: Color
  public let outlineVariant: Color
  public let scrim: Color

  public init(
    primary: Color,
    onPrimary: Color,
    primaryContainer: Color,
    onPrimaryContainer: Color,
    inversePrimary: Color,
    secondary: Color,
    onSecondary: Color,
    secondaryContainer: Color,
    onSecondaryContainer: Color,
    tertiary: Color,
    onTertiary: Color,
    tertiaryContainer: Color,
    onTertiaryContainer: Color,
    background: Color,
    onBackground: Color,
    surface: Color,
    onSurface: Color,
    surfaceVariant: Color,
    onSurfaceVariant: Color,
    surfaceTint: Color,
    inverseSurface: Color,
    inverseOnSurface: Color,
    error: Color,
    onError: Color,
    errorContainer: Color,
    onErrorContainer: Color,
    outline: Color,
    outlineVariant: Color,
    scrim: Color
  ) {
    self.primary = primary
    self.onPrimary = onPrimary
    self.primaryContainer = primaryContainer
    self.onPrimaryContainer = onPrimaryContainer
    self.inversePrimary = inversePrimary
    self.secondary = secondary
    self.onSecondary = onSecondary
    self.secondaryContainer = secondaryContainer
    self.onSecondaryContainer = onSecondaryContainer
    self.tertiary = tertiary
    self.onTertiary = onTertiary
    self.tertiaryContainer = tertiaryContainer
    self.onTertiaryContainer = onTertiaryContainer
    self.background = background
    self.onBackground = onBackground
    self.surface = surface
    self.onSurface = onSurface
    self.surfaceVariant = surfaceVariant
    self.onSurfaceVariant = onSurfaceVariant
    self.surfaceTint = surfaceTint
    self.inverseSurface = inverseSurface
    self.inverseOnSurface = inverseOnSurface
    self.error = error
    self.onError = onError
    self.errorContainer = errorContainer
    self.onErrorContainer = onErrorContainer
    self.outline = outline
    self.outlineVariant = outlineVariant
    self.scrim = scrim
  }
}

public extension DSColorTheme {
  static let `default` = DSColorTheme(
    primary: DSDefaultColors.primary,
    onPrimary: DSDefaultColors.onPrimary,
    primaryContainer: DSDefaultColors.primaryContainer,
    onPrimaryContainer: DSDefaultColors.onPrimaryContainer,
    inversePrimary: DSDefaultColors.inversePrimary,
    secondary: DSDefaultColors.secondary,
    onSecondary: DSDefaultColors.onSecondary,
    secondaryContainer: DSDefaultColors.secondaryContainer,
    onSecondaryContainer: DSDefaultColors.onSecondaryContainer,
    tertiary: DSDefaultColors.tertiary,
    onTertiary: DSDefaultColors.onTertiary,
    tertiaryContainer: DSDefaultColors.tertiaryContainer,
    onTertiaryContainer: DSDefaultColors.onTertiaryContainer,
    background: DSDefaultColors.background,
    onBackground: DSDefaultColors.onBackground,
    surface: DSDefaultColors.surface,
    onSurface: DSDefaultColors.onSurface,
    surfaceVariant: DSDefaultColors.surfaceVariant,
    onSurfaceVariant: DSDefaultColors.onSurfaceVariant,
    surfaceTint: DSDefaultColors.surfaceTint,
    inverseSurface: DSDefaultColors.inverseSurface,
    inverseOnSurface: DSDefaultColors.inverseOnSurface,
    error: DSDefaultColors.error,
    onError: DSDefaultColors.onError,
    errorContainer: DSDefaultColors.errorContainer,
    onErrorContainer: DSDefaultColors.onErrorContainer,
    outline: DSDefaultColors.outline,
    outlineVariant: DSDefaultColors.outlineVariant,
    scrim: DSDefaultColors.scrim
  )
}
