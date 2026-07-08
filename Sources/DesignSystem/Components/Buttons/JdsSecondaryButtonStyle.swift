import SwiftUI

public struct JdsSecondaryButtonStyle: ButtonStyle {
  private let size: JdsButtonSize
  private let isFullWidth: Bool
  private let cornerRadius: CGFloat

  public init(
    size: JdsButtonSize = .medium,
    isFullWidth: Bool = false,
    cornerRadius: CGFloat = .cornerRadiusXXL
  ) {
    self.size = size
    self.isFullWidth = isFullWidth
    self.cornerRadius = cornerRadius
  }

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .modifier(
        ButtonAppearanceModifier(
          appearance: .standard,
          size: size,
          isFullWidth: isFullWidth,
          cornerRadius: cornerRadius,
          isPressed: configuration.isPressed,
          pressedOverlayOpacity: 0.10
        )
      )
  }
}

#if DEBUG
#Preview("Secondary Button") {
  VStack(spacing: .spacingS) {
    Button("Secondary", systemImage: "sparkles") {}
      .buttonStyle(.JdsSecondary)

    Button("Full width secondary") {}
      .buttonStyle(.JdsSecondary(isFullWidth: true))

    Button("Square secondary") {}
      .buttonStyle(.JdsSecondary(cornerRadius: .cornerRadiusNone))

    Button("Medium radius secondary") {}
      .buttonStyle(.JdsSecondary(cornerRadius: .cornerRadiusM))

    Button("Disabled") {}
      .buttonStyle(.JdsSecondary)
      .disabled(true)
  }
  .padding(.spacingM)
}
#endif

public extension ButtonStyle where Self == JdsSecondaryButtonStyle {
  static var JdsSecondary: Self { .init() }

  static func JdsSecondary(
    size: JdsButtonSize = .medium,
    isFullWidth: Bool = false,
    cornerRadius: CGFloat = .cornerRadiusXXL
  ) -> Self {
    .init(size: size, isFullWidth: isFullWidth, cornerRadius: cornerRadius)
  }
}
