import SwiftUI

#if !os(visionOS)

public struct DSGlassIconButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled

  private let prominence: DSIconButtonProminence
  private let size: DSButtonSize?
  private let appearance: DSButtonAppearance?

  public init(
    prominence: DSIconButtonProminence = .plain,
    size: DSButtonSize? = nil,
    appearance: DSButtonAppearance? = nil
  ) {
    self.prominence = prominence
    self.size = size
    self.appearance = appearance
  }

  public func makeBody(configuration: Configuration) -> some View {
    let appearance = appearance ?? prominence.appearance
    let visualState = appearance.visualState(isEnabled: isEnabled, isPressed: false)

    DSCircularButtonLabel(
      label: configuration.label,
      variant: .icon,
      size: size,
      foreground: visualState.foreground
    )
    .modifier(DSGlassButtonSurface(appearance: appearance, isEnabled: isEnabled))
  }
}

public extension ButtonStyle where Self == DSGlassIconButtonStyle {
  static var dsGlassIcon: Self {
    .init()
  }

  static func dsGlassIcon(
    prominence: DSIconButtonProminence = .plain,
    size: DSButtonSize? = nil,
    appearance: DSButtonAppearance? = nil
  ) -> Self {
    .init(
      prominence: prominence,
      size: size,
      appearance: appearance
    )
  }
}

#if DEBUG
private extension DSSystemSymbol {
  static let search = Self("magnifyingglass")
}

#Preview("Glass icon plain") {
  Button("Search", systemSymbol: .search) {}
    .buttonStyle(.dsGlassIcon)
    .padding(.spacingXL)
    .background(.dsPrimaryContainer)
}

#Preview("Glass icon primary") {
  Button("Search", systemSymbol: .search) {}
    .buttonStyle(.dsGlassIcon(prominence: .primary))
    .padding(.spacingXL)
    .background(.dsPrimaryContainer)
}
#endif
#endif
