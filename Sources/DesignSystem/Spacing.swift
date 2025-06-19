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
      case .xxs: return 4
      case .xs:  return 8
      case .sm:  return 12
      case .md:  return 16
      case .lg:  return 24
      case .xl:  return 32
      case .xxl: return 48
    }
  }
}
