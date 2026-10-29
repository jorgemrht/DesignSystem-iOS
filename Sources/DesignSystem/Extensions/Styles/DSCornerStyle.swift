import SwiftUI

public enum DSCornerStyle: Sendable, Hashable {
  case capsule
  case fixed(CGFloat)
  case concentric(minimum: CGFloat = .cornerRadiusM)
}

extension DSCornerStyle {
  static func resolved(
    _ explicit: DSCornerStyle?,
    inherited: DSCornerStyle?,
    default defaultStyle: DSCornerStyle
  ) -> DSCornerStyle {
    explicit ?? inherited ?? defaultStyle
  }
}

public extension EnvironmentValues {
  @Entry var dsCornerStyle: DSCornerStyle?
}

public extension View {
  func dsCornerStyle(_ style: DSCornerStyle?) -> some View {
    environment(\.dsCornerStyle, style)
  }
}

extension ConcentricRectangle {
  init(minimumRadius: CGFloat) {
    self.init(corners: .concentric(minimum: .fixed(minimumRadius)), isUniform: true)
  }
}
