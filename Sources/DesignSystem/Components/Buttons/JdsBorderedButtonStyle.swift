import SwiftUI

public struct JdsBorderedButtonStyle: ButtonStyle {
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
          appearance: .bordered,
          size: size,
          isFullWidth: isFullWidth,
          cornerRadius: cornerRadius,
          isPressed: configuration.isPressed,
          pressedOverlayOpacity: 0.10
        )
      )
  }
}

public extension ButtonStyle where Self == JdsBorderedButtonStyle {
  static var JdsBordered: Self { .init() }

  static func JdsBordered(
    size: JdsButtonSize = .medium,
    isFullWidth: Bool = false,
    cornerRadius: CGFloat = .cornerRadiusXXL
  ) -> Self {
    .init(size: size, isFullWidth: isFullWidth, cornerRadius: cornerRadius)
  }
}

#if DEBUG
#Preview("Bordered Button") {
  VStack(spacing: .spacingS) {
    Button("Bordered", systemImage: "square.and.pencil") {}
      .buttonStyle(.JdsBordered)

    Button("Full width bordered") {}
      .buttonStyle(.JdsBordered(isFullWidth: true))

    Button("Square bordered") {}
      .buttonStyle(.JdsBordered(cornerRadius: .cornerRadiusNone))

    Button("Medium radius bordered") {}
      .buttonStyle(.JdsBordered(cornerRadius: .cornerRadiusM))

    Button("Disabled") {}
      .buttonStyle(.JdsBordered)
      .disabled(true)
  }
  .padding(.spacingM)
}
#endif
