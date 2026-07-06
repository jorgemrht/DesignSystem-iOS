import CoreGraphics

public enum Spacing {
  /// Extra extra small — 4 px
  case xxs
  /// Extra small — 8 px
  case xs
  /// Small — 12 px
  case sm
  /// Medium — 16 px
  case md
  /// Large — 24 px
  case lg
  /// Extra large — 32 px
  case xl
  /// Extra extra large — 48 px
  case xxl

  public var value: CGFloat {
    switch self {
      case .xxs: 4
      case .xs: 8
      case .sm: 12
      case .md: 16
      case .lg: 24
      case .xl: 32
      case .xxl: 48
    }
  }
}
