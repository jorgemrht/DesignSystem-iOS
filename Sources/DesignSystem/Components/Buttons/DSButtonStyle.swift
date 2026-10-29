import SwiftUI

public struct DSButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.accessibilityShowBorders) private var showsBorders
  @Environment(\.controlSize) private var controlSize
  @Environment(\.buttonSizing) private var buttonSizing
  @Environment(\.dsCornerStyle) private var inheritedCornerStyle

  let hierarchy: DSButtonHierarchy
  let size: DSButtonSize?
  let cornerStyle: DSCornerStyle?
  let appearance: DSButtonAppearance?

  public func makeBody(configuration: Configuration) -> some View {
    let size = size ?? DSButtonSize(controlSize)
    let fillsWidth = buttonSizing == .flexible
    let appearance = appearance ?? hierarchy.appearance(isDestructive: configuration.role == .destructive)
    let visualState = appearance.visualState(
      isEnabled: isEnabled,
      isPressed: configuration.isPressed,
      showsBorders: showsBorders
    )

    let label = configuration.label
      .font(size.labelFont)
      .multilineTextAlignment(.center)
      .foregroundStyle(visualState.foreground)
      .padding(.horizontal, size.horizontalPadding)
      .frame(maxWidth: fillsWidth ? .infinity : nil)
      .frame(minHeight: size.minHeight)

    switch DSCornerStyle.resolved(cornerStyle, inherited: inheritedCornerStyle, default: .capsule) {
    case .capsule:
      label.modifier(DSButtonSurface(visualState: visualState, shape: Capsule()))
    case let .fixed(radius):
      label.modifier(DSButtonSurface(visualState: visualState, shape: RoundedRectangle(cornerRadius: radius)))
    case let .concentric(minimum):
      label.modifier(
        DSButtonSurface(
          visualState: visualState,
          shape: ConcentricRectangle(minimumRadius: minimum)
        )
      )
    }
  }
}

enum DSButtonHierarchy {
  case primary
  case secondary
  case bordered
  case tertiary

  func appearance(isDestructive: Bool) -> DSButtonAppearance {
    switch (self, isDestructive) {
    case (.primary, false): .primary
    case (.secondary, false): .secondary
    case (.bordered, false): .bordered
    case (.tertiary, false): .tertiary
    case (.primary, true): .destructivePrimary
    case (.secondary, true): .destructiveSecondary
    case (.bordered, true): .destructiveBordered
    case (.tertiary, true): .destructiveTertiary
    }
  }
}

public extension ButtonStyle where Self == DSButtonStyle {
  static var dsPrimary: Self {
    .dsPrimary()
  }

  static func dsPrimary(
    size: DSButtonSize? = nil,
    cornerStyle: DSCornerStyle? = nil,
    appearance: DSButtonAppearance? = nil
  ) -> Self {
    .init(
      hierarchy: .primary,
      size: size,
      cornerStyle: cornerStyle,
      appearance: appearance
    )
  }

  static var dsSecondary: Self {
    .dsSecondary()
  }

  static func dsSecondary(
    size: DSButtonSize? = nil,
    cornerStyle: DSCornerStyle? = nil,
    appearance: DSButtonAppearance? = nil
  ) -> Self {
    .init(
      hierarchy: .secondary,
      size: size,
      cornerStyle: cornerStyle,
      appearance: appearance
    )
  }

  static var dsBordered: Self {
    .dsBordered()
  }

  static func dsBordered(
    size: DSButtonSize? = nil,
    cornerStyle: DSCornerStyle? = nil,
    appearance: DSButtonAppearance? = nil
  ) -> Self {
    .init(
      hierarchy: .bordered,
      size: size,
      cornerStyle: cornerStyle,
      appearance: appearance
    )
  }

  static var dsTertiary: Self {
    .dsTertiary()
  }

  static func dsTertiary(
    size: DSButtonSize? = nil,
    cornerStyle: DSCornerStyle? = nil,
    appearance: DSButtonAppearance? = nil
  ) -> Self {
    .init(
      hierarchy: .tertiary,
      size: size,
      cornerStyle: cornerStyle,
      appearance: appearance
    )
  }
}

#if DEBUG
#Preview("Primary") {
  Button("Primary") {}
    .buttonStyle(.dsPrimary)
    .padding(.spacingS)
    .background(.dsBackground)
}

#Preview("Secondary") {
  Button("Secondary") {}
    .buttonStyle(.dsSecondary)
    .padding(.spacingS)
    .background(.dsBackground)
}

#Preview("Bordered") {
  Button("Bordered") {}
    .buttonStyle(.dsBordered)
    .padding(.spacingS)
    .background(.dsBackground)
}

#Preview("Tertiary") {
  Button("Tertiary") {}
    .buttonStyle(.dsTertiary)
    .padding(.spacingS)
    .background(.dsBackground)
}

#Preview("Disabled") {
  Button("Disabled") {}
    .buttonStyle(.dsPrimary)
    .disabled(true)
    .padding(.spacingS)
    .background(.dsBackground)
}
#endif
