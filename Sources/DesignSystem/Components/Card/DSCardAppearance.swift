import SwiftUI

public enum DSCardVariant: Sendable, CaseIterable {
  case filled
  case elevated
  case outlined
}

public struct DSCardAppearance: Sendable {
  public let filledContainer: Color
  public let container: Color
  public let outline: Color
  public let shadow: DSShadow

  public init(
    filledContainer: Color,
    container: Color,
    outline: Color,
    shadow: DSShadow = .raised
  ) {
    self.filledContainer = filledContainer
    self.container = container
    self.outline = outline
    self.shadow = shadow
  }

  public static let standard = tinted(.dsSurfaceVariant)

  public static func tinted(_ color: Color) -> Self {
    Self(
      filledContainer: color,
      container: .dsSurface,
      outline: .dsOutlineVariant
    )
  }

  func containerColor(for variant: DSCardVariant) -> Color {
    variant == .filled ? filledContainer : container
  }

  func outlineColor(for variant: DSCardVariant) -> Color? {
    variant == .outlined ? outline : nil
  }

  func shadow(for variant: DSCardVariant) -> DSShadow? {
    variant == .elevated ? shadow : nil
  }
}
