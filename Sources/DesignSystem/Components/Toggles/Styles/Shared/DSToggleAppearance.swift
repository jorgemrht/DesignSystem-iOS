import SwiftUI

public struct DSToggleAppearance: Sendable {
  public let onTrack: Color
  public let onThumb: Color
  public let offTrack: Color
  public let offThumb: Color
  public let offOutline: Color
  public let label: Color
  public let disabledOnTrack: Color
  public let disabledOnThumb: Color
  public let disabledOffTrack: Color
  public let disabledOffThumb: Color
  public let disabledOffOutline: Color
  public let disabledLabel: Color

  public init(
    onTrack: Color,
    onThumb: Color,
    offTrack: Color,
    offThumb: Color,
    offOutline: Color,
    label: Color,
    disabledOnTrack: Color = .dsOnSurface.opacity(.opacityDisabled),
    disabledOnThumb: Color = .dsSurface,
    disabledOffTrack: Color = .dsSurfaceVariant.opacity(.opacityDisabledSubtle),
    disabledOffThumb: Color = .dsOnSurface.opacity(.opacityDisabled),
    disabledOffOutline: Color = .dsOnSurface.opacity(.opacityDisabledSubtle),
    disabledLabel: Color = .dsOnSurface.opacity(.opacityDisabled)
  ) {
    self.onTrack = onTrack
    self.onThumb = onThumb
    self.offTrack = offTrack
    self.offThumb = offThumb
    self.offOutline = offOutline
    self.label = label
    self.disabledOnTrack = disabledOnTrack
    self.disabledOnThumb = disabledOnThumb
    self.disabledOffTrack = disabledOffTrack
    self.disabledOffThumb = disabledOffThumb
    self.disabledOffOutline = disabledOffOutline
    self.disabledLabel = disabledLabel
  }

  public static let standard = tinted(.dsPrimary)

  public static func tinted(_ color: Color) -> Self {
    Self(
      onTrack: color,
      onThumb: .dsOnPrimary,
      offTrack: .dsSurfaceVariant,
      offThumb: .dsOutline,
      offOutline: .dsOutline,
      label: .dsOnSurface
    )
  }

  func trackColor(isOn: Bool, isEnabled: Bool) -> Color {
    switch (isOn, isEnabled) {
    case (true, true): onTrack
    case (true, false): disabledOnTrack
    case (false, true): offTrack
    case (false, false): disabledOffTrack
    }
  }

  func thumbColor(isOn: Bool, isEnabled: Bool) -> Color {
    switch (isOn, isEnabled) {
    case (true, true): onThumb
    case (true, false): disabledOnThumb
    case (false, true): offThumb
    case (false, false): disabledOffThumb
    }
  }

  func outlineColor(isOn: Bool, isEnabled: Bool) -> Color {
    guard !isOn else { return .clear }
    return isEnabled ? offOutline : disabledOffOutline
  }

  func labelColor(isEnabled: Bool) -> Color {
    isEnabled ? label : disabledLabel
  }
}
