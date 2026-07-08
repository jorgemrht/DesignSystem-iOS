import SwiftUI

public enum JdsFABButtonVariant: Sendable {
  case surface
  case primary
  case secondary
  case tertiary

  var foreground: Color {
    switch self {
    case .surface: .dsPrimary
    case .primary: .dsOnPrimaryContainer
    case .secondary: .dsOnSecondaryContainer
    case .tertiary: .dsOnTertiaryContainer
    }
  }

  var container: Color {
    switch self {
    case .surface: .dsSurfaceContainerHigh
    case .primary: .dsPrimaryContainer
    case .secondary: .dsSecondaryContainer
    case .tertiary: .dsTertiaryContainer
    }
  }
}

public enum JdsFABButtonSize: Sendable {
  case small
  case medium
  case large

  var minSize: CGFloat {
    switch self {
    case .small: 44
    case .medium: 56
    case .large: 96
    }
  }

  var iconFont: CGFloat {
    switch self {
    case .small, .medium: 24
    case .large: 36
    }
  }
}

public struct JdsFABButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled

  private let variant: JdsFABButtonVariant
  private let size: JdsFABButtonSize
  private let shadow: JdsButtonShadow?

  public init(
    variant: JdsFABButtonVariant = .surface,
    size: JdsFABButtonSize = .medium,
    shadow: JdsButtonShadow? = .floating
  ) {
    self.variant = variant
    self.size = size
    self.shadow = shadow
  }

  public func makeBody(configuration: Configuration) -> some View {
    let container = isEnabled ? variant.container : .dsOnSurface.opacity(0.12)
    let foreground = isEnabled ? variant.foreground : .dsOnSurface.opacity(0.38)
    let iconForeground = isEnabled && configuration.isPressed ? foreground.opacity(0.72) : foreground
    let shadow = isEnabled ? shadow : nil

    configuration.label
      .labelStyle(.iconOnly)
      .font(.system(size: size.iconFont, weight: .semibold))
      .foregroundStyle(iconForeground)
      .frame(width: size.minSize, height: size.minSize)
      .background {
        Circle().fill(container)
      }
      .clipShape(Circle())
      .contentShape(Circle())
      .shadow(
        color: shadow?.color ?? .clear,
        radius: shadow?.radius ?? 0,
        x: shadow?.x ?? 0,
        y: shadow?.y ?? 0
      )
  }
}

public extension ButtonStyle where Self == JdsFABButtonStyle {
  static var JdsFAB: Self { .init() }

  static func JdsFAB(
    variant: JdsFABButtonVariant = .surface,
    size: JdsFABButtonSize = .medium,
    shadow: JdsButtonShadow? = .floating
  ) -> Self {
    .init(variant: variant, size: size, shadow: shadow)
  }
}

#if DEBUG
#Preview("FAB Button") {
  HStack(spacing: .spacingS) {
    Button("Edit", systemImage: "pencil") {}
      .labelStyle(.iconOnly)
      .buttonStyle(.JdsFAB(size: .small))

    Button("Add", systemImage: "plus") {}
      .labelStyle(.iconOnly)
      .buttonStyle(.JdsFAB)

    Button("Create", systemImage: "plus") {}
      .buttonStyle(.JdsFAB(variant: .primary, shadow: nil))

    Button("Large", systemImage: "sparkles") {}
      .labelStyle(.iconOnly)
      .buttonStyle(.JdsFAB(variant: .tertiary, size: .large))
  }
  .padding(.spacingM)
}
#endif
