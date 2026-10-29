import SwiftUI

public struct DSFABButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.accessibilityShowBorders) private var showsBorders

  private let variant: DSFABButtonVariant
  private let size: DSButtonSize?
  private let shadow: DSShadow?
  private let appearance: DSButtonAppearance?

  public init(
    variant: DSFABButtonVariant = .primaryContainer,
    size: DSButtonSize? = nil,
    shadow: DSShadow? = .floating,
    appearance: DSButtonAppearance? = nil
  ) {
    self.variant = variant
    self.size = size
    self.shadow = shadow
    self.appearance = appearance
  }

  public func makeBody(configuration: Configuration) -> some View {
    let appearance = appearance ?? variant.appearance
    let visualState = appearance.visualState(
      isEnabled: isEnabled,
      isPressed: configuration.isPressed,
      showsBorders: showsBorders
    )

    DSCircularButtonLabel(
      label: configuration.label,
      variant: .fab,
      size: size,
      foreground: visualState.foreground
    )
    .modifier(DSButtonSurface(visualState: visualState, shape: Circle(), shadow: isEnabled ? shadow : nil))
  }
}

public extension ButtonStyle where Self == DSFABButtonStyle {
  static var dsFAB: Self {
    .init()
  }

  static func dsFAB(
    variant: DSFABButtonVariant = .primaryContainer,
    size: DSButtonSize? = nil,
    shadow: DSShadow? = .floating,
    appearance: DSButtonAppearance? = nil
  ) -> Self {
    .init(
      variant: variant,
      size: size,
      shadow: shadow,
      appearance: appearance
    )
  }
}

#if DEBUG
private extension DSSystemSymbol {
  static let add = Self("plus")
}

#Preview("FAB primary") {
  Button("Add", systemSymbol: .add) {}
    .buttonStyle(.dsFAB)
    .padding(.spacingS)
    .background(.dsBackground)
}

#Preview("FAB tertiary") {
  Button("Add", systemSymbol: .add) {}
    .buttonStyle(.dsFAB(variant: .tertiaryContainer))
    .padding(.spacingS)
    .background(.dsBackground)
}

#Preview("FAB disabled") {
  Button("Add", systemSymbol: .add) {}
    .buttonStyle(.dsFAB)
    .disabled(true)
    .padding(.spacingS)
    .background(.dsBackground)
}
#endif
