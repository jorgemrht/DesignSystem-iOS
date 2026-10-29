import SwiftUI

#if !os(visionOS)

public struct DSGlassFABButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled

  private let variant: DSFABButtonVariant
  private let size: DSButtonSize?
  private let appearance: DSButtonAppearance?

  public init(
    variant: DSFABButtonVariant = .primaryContainer,
    size: DSButtonSize? = nil,
    appearance: DSButtonAppearance? = nil
  ) {
    self.variant = variant
    self.size = size
    self.appearance = appearance
  }

  public func makeBody(configuration: Configuration) -> some View {
    let appearance = appearance ?? variant.appearance
    let visualState = appearance.visualState(isEnabled: isEnabled, isPressed: false)

    DSCircularButtonLabel(
      label: configuration.label,
      variant: .fab,
      size: size,
      foreground: visualState.foreground
    )
    .modifier(DSGlassButtonSurface(appearance: appearance, isEnabled: isEnabled))
  }
}

public extension ButtonStyle where Self == DSGlassFABButtonStyle {
  static var dsGlassFAB: Self {
    .init()
  }

  static func dsGlassFAB(
    variant: DSFABButtonVariant = .primaryContainer,
    size: DSButtonSize? = nil,
    appearance: DSButtonAppearance? = nil
  ) -> Self {
    .init(
      variant: variant,
      size: size,
      appearance: appearance
    )
  }
}

#if DEBUG
private extension DSSystemSymbol {
  static let add = Self("plus")
}

#Preview("Glass FAB primary") {
  Button("Add", systemSymbol: .add) {}
    .buttonStyle(.dsGlassFAB)
    .padding(.spacingXL)
    .background(.dsPrimaryContainer)
}

#Preview("Glass FAB secondary") {
  Button("Add", systemSymbol: .add) {}
    .buttonStyle(.dsGlassFAB(variant: .secondaryContainer))
    .padding(.spacingXL)
    .background(.dsPrimaryContainer)
}
#endif
#endif
