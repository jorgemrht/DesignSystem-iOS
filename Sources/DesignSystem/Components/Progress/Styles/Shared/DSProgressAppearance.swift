import SwiftUI

public struct DSProgressAppearance: Sendable {
  public let indicator: Color
  public let track: Color
  public let label: Color
  public let value: Color

  public init(indicator: Color, track: Color, label: Color, value: Color) {
    self.indicator = indicator
    self.track = track
    self.label = label
    self.value = value
  }

  public static let standard = tinted(.dsPrimary)

  public static func tinted(_ color: Color) -> Self {
    Self(
      indicator: color,
      track: .dsSecondaryContainer,
      label: .dsOnSurface,
      value: .dsOnSurfaceVariant
    )
  }
}
