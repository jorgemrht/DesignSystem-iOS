import SwiftUI

public struct JdsPrimaryButtonStyle: ButtonStyle {
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
          appearance: .prominent,
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
#Preview("Primary Button") {
  VStack(spacing: .spacingS) {
    Button("Primary", systemImage: "checkmark") {}
      .buttonStyle(.JdsPrimary)

    Button("Full width primary") {}
      .buttonStyle(.JdsPrimary(isFullWidth: true))

    Button("Square primary") {}
      .buttonStyle(.JdsPrimary(cornerRadius: .cornerRadiusNone))

    Button("Medium radius primary") {}
      .buttonStyle(.JdsPrimary(cornerRadius: .cornerRadiusM))

    Button("Disabled") {}
      .buttonStyle(.JdsPrimary)
      .disabled(true)
  }
  .padding(.spacingM)
}
#endif

public extension ButtonStyle where Self == JdsPrimaryButtonStyle {
  static var JdsPrimary: Self { .init() }

  static func JdsPrimary(
    size: JdsButtonSize = .medium,
    isFullWidth: Bool = false,
    cornerRadius: CGFloat = .cornerRadiusXXL
  ) -> Self {
    .init(size: size, isFullWidth: isFullWidth, cornerRadius: cornerRadius)
  }
}
