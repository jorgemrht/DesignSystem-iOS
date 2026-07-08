import SwiftUI

public struct JdsTertiaryButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled

  private let size: JdsButtonSize
  private let isFullWidth: Bool

  public init(
    size: JdsButtonSize = .medium,
    isFullWidth: Bool = false
  ) {
    self.size = size
    self.isFullWidth = isFullWidth
  }

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(size.labelFont)
      .multilineTextAlignment(.center)
      .foregroundStyle(foregroundColor(isPressed: configuration.isPressed))
      .padding(.horizontal, size.horizontalPadding)
      .frame(maxWidth: isFullWidth ? .infinity : nil)
      .frame(minHeight: size.minHeight)
      .contentShape(Capsule())
  }

  private func foregroundColor(isPressed: Bool) -> Color {
    guard isEnabled else { return .dsOnSurface.opacity(0.38) }
    return isPressed ? .dsPrimary.opacity(0.62) : .dsPrimary
  }
}

#if DEBUG
#Preview("Tertiary Button") {
  VStack(spacing: .spacingS) {
    Button("Tertiary", systemImage: "text.cursor") {}
      .buttonStyle(.JdsTertiary)

    Button("Full width tertiary") {}
      .buttonStyle(.JdsTertiary(isFullWidth: true))

    Button("Disabled") {}
      .buttonStyle(.JdsTertiary)
      .disabled(true)
  }
  .padding(.spacingM)
}
#endif

public extension ButtonStyle where Self == JdsTertiaryButtonStyle {
  static var JdsTertiary: Self { .init() }

  static func JdsTertiary(
    size: JdsButtonSize = .medium,
    isFullWidth: Bool = false
  ) -> Self {
    .init(size: size, isFullWidth: isFullWidth)
  }
}
