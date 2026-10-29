import SwiftUI

public extension DSButtonAppearance {
  static let primary: DSButtonAppearance = filled(.dsPrimary, foreground: .dsOnPrimary)
  static let secondary: DSButtonAppearance = filled(.dsSecondaryContainer, foreground: .dsOnSecondaryContainer)
  static let bordered: DSButtonAppearance = outlined(.dsPrimary)
  static let tertiary: DSButtonAppearance = text(.dsPrimary)
  static let plain: DSButtonAppearance = plain(.dsOnSurfaceVariant)
  static let primaryContainer: DSButtonAppearance = container(.dsPrimaryContainer, foreground: .dsOnPrimaryContainer)
  static let secondaryContainer: DSButtonAppearance = container(
    .dsSecondaryContainer,
    foreground: .dsOnSecondaryContainer
  )
  static let tertiaryContainer: DSButtonAppearance = container(
    .dsTertiaryContainer,
    foreground: .dsOnTertiaryContainer
  )

  static let destructivePrimary: DSButtonAppearance = filled(.dsError, foreground: .dsOnError)
  static let destructiveSecondary: DSButtonAppearance = filled(.dsErrorContainer, foreground: .dsOnErrorContainer)
  static let destructiveBordered: DSButtonAppearance = outlined(.dsError, border: .dsError)
  static let destructiveTertiary: DSButtonAppearance = text(.dsError)

  static func filled(_ background: Color, foreground: Color) -> DSButtonAppearance {
    DSButtonAppearance(
      foreground: foreground,
      background: background,
      pressedOverlay: foreground,
      disabledForeground: foreground.opacity(.opacityDisabledOnFill),
      disabledBackground: background.opacity(.opacityDisabled)
    )
  }

  static func outlined(_ color: Color, border: Color = .dsOutline) -> DSButtonAppearance {
    DSButtonAppearance(
      foreground: color,
      background: nil,
      border: border,
      pressedOverlay: color,
      disabledForeground: color.opacity(.opacityDisabled),
      disabledBackground: nil,
      disabledBorder: color.opacity(.opacityDisabledOutline)
    )
  }

  static func text(_ color: Color) -> DSButtonAppearance {
    DSButtonAppearance(
      foreground: color,
      pressedForeground: color.opacity(.opacityPressedContent),
      background: nil,
      pressedOverlay: .clear,
      pressedOverlayOpacity: 0,
      disabledForeground: color.opacity(.opacityDisabled),
      disabledBackground: nil
    )
  }

  static func plain(_ color: Color) -> DSButtonAppearance {
    DSButtonAppearance(
      foreground: color,
      background: nil,
      pressedOverlay: color,
      disabledForeground: color.opacity(.opacityDisabled),
      disabledBackground: nil
    )
  }

  static func container(_ background: Color, foreground: Color) -> DSButtonAppearance {
    DSButtonAppearance(
      foreground: foreground,
      background: background,
      pressedOverlay: foreground,
      disabledForeground: foreground.opacity(.opacityDisabled),
      disabledBackground: background.opacity(.opacityDisabled)
    )
  }
}

private extension Double {
  static let opacityDisabledOnFill: Double = 0.55
}
