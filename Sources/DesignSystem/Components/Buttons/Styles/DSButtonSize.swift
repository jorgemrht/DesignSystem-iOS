import SwiftUI

public enum DSButtonSize: Sendable, CaseIterable {
  case small
  case medium
  case large

  init(_ controlSize: ControlSize) {
    self = switch controlSize {
    case .mini, .small: .small
    case .regular: .medium
    case .large, .extraLarge: .large
    @unknown default: .medium
    }
  }

  var minHeight: CGFloat {
    switch self {
    case .small: .controlSizeS
    case .medium: .controlSizeM
    case .large: .controlSizeL
    }
  }

  var horizontalPadding: CGFloat {
    switch self {
    case .small: .spacingS
    case .medium: .spacingM
    case .large: .spacingL
    }
  }

  var labelFont: Font {
    switch self {
    case .small: .callout
    case .medium, .large: .body
    }
  }

  var iconButtonDiameter: CGFloat {
    minHeight
  }

  var iconButtonFont: Font {
    switch self {
    case .small: .body
    case .medium: .title3
    case .large: .title2
    }
  }

  var fabDiameter: CGFloat {
    switch self {
    case .small: .controlSizeS
    case .medium: .controlSizeL
    case .large: .controlSizeXL
    }
  }

  var fabIconSize: CGFloat {
    switch self {
    case .small, .medium: .iconSizeM
    case .large: .iconSizeL
    }
  }
}
