import SwiftUI

public struct DSButtonAppearance: Sendable {
  public static let disabledForeground = Color.dsOnSurface.opacity(.opacityDisabled)
  public static let disabledBackground = Color.dsOnSurface.opacity(.opacityDisabledSubtle)
  public static let disabledBorder = Color.dsOnSurface.opacity(.opacityDisabledSubtle)

  public let foreground: Color
  public let pressedForeground: Color?
  public let background: Color?
  public let border: Color?
  public let pressedOverlay: Color
  public let pressedOverlayOpacity: Double
  public let disabledForeground: Color
  public let disabledBackground: Color?
  public let disabledBorder: Color?

  public init(
    foreground: Color,
    pressedForeground: Color? = nil,
    background: Color?,
    border: Color? = nil,
    pressedOverlay: Color,
    pressedOverlayOpacity: Double = .opacityPressedOverlay,
    disabledForeground: Color = Self.disabledForeground,
    disabledBackground: Color? = Self.disabledBackground,
    disabledBorder: Color? = nil
  ) {
    self.foreground = foreground
    self.pressedForeground = pressedForeground
    self.background = background
    self.border = border
    self.pressedOverlay = pressedOverlay
    self.pressedOverlayOpacity = pressedOverlayOpacity
    self.disabledForeground = disabledForeground
    self.disabledBackground = disabledBackground
    self.disabledBorder = disabledBorder
  }
}
