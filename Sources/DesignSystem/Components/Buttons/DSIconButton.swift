import SwiftUI

public struct DSIconButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.accessibilityShowBorders) private var showsBorders

  private let prominence: DSIconButtonProminence
  private let size: DSButtonSize?
  private let appearance: DSButtonAppearance?
  private let customSize: CGFloat?
  private let customFont: Font?

  public init(
    prominence: DSIconButtonProminence = .plain,
    size: DSButtonSize? = nil,
    appearance: DSButtonAppearance? = nil,
    customSize: CGFloat? = nil,
    customFont: Font? = nil
  ) {
    self.prominence = prominence
    self.size = size
    self.appearance = appearance
    self.customSize = customSize
    self.customFont = customFont
  }

  public func makeBody(configuration: Configuration) -> some View {
    let appearance = appearance ?? prominence.appearance
    let visualState = appearance.visualState(
      isEnabled: isEnabled,
      isPressed: configuration.isPressed,
      showsBorders: showsBorders
    )

    DSCircularButtonLabel(
      label: configuration.label,
      variant: .icon,
      size: size,
      foreground: visualState.foreground,
      customDiameter: customSize,
      customFont: customFont
    )
    .modifier(DSButtonSurface(visualState: visualState, shape: Circle()))
  }
}

public extension ButtonStyle where Self == DSIconButtonStyle {
  static var dsIcon: Self {
    .init()
  }

  static func dsIcon(
    prominence: DSIconButtonProminence = .plain,
    size: DSButtonSize? = nil,
    appearance: DSButtonAppearance? = nil,
    customSize: CGFloat? = nil,
    customFont: Font? = nil
  ) -> Self {
    .init(
      prominence: prominence,
      size: size,
      appearance: appearance,
      customSize: customSize,
      customFont: customFont
    )
  }
}

public struct DSIconButton: View {
  private let title: LocalizedStringResource
  private let systemSymbol: DSSystemSymbol
  private let style: DSIconButtonStyle
  private let isEnabled: Bool
  private let role: ButtonRole?
  private let action: @MainActor () -> Void

  public init(
    _ title: LocalizedStringResource,
    systemSymbol: DSSystemSymbol,
    prominence: DSIconButtonProminence = .plain,
    size: DSButtonSize? = nil,
    appearance: DSButtonAppearance? = nil,
    customSize: CGFloat? = nil,
    customFont: Font? = nil,
    isEnabled: Bool = true,
    role: ButtonRole? = nil,
    action: @escaping @MainActor () -> Void
  ) {
    self.title = title
    self.systemSymbol = systemSymbol
    style = DSIconButtonStyle(
      prominence: prominence,
      size: size,
      appearance: appearance,
      customSize: customSize,
      customFont: customFont
    )
    self.isEnabled = isEnabled
    self.role = role
    self.action = action
  }

  public var body: some View {
    Button(title, systemSymbol: systemSymbol, role: role, action: action)
      .buttonStyle(style)
      .disabled(!isEnabled)
  }
}

#if DEBUG
private extension DSSystemSymbol {
  static let search = Self("magnifyingglass")
}

#Preview("Icon plain") {
  DSIconButton("Search", systemSymbol: .search) {}
    .padding(.spacingS)
    .background(.dsBackground)
}

#Preview("Icon bordered") {
  DSIconButton("Search", systemSymbol: .search, prominence: .bordered) {}
    .padding(.spacingS)
    .background(.dsBackground)
}

#Preview("Icon primary") {
  DSIconButton("Search", systemSymbol: .search, prominence: .primary) {}
    .padding(.spacingS)
    .background(.dsBackground)
}

#Preview("Icon disabled") {
  DSIconButton("Search", systemSymbol: .search, isEnabled: false) {}
    .padding(.spacingS)
    .background(.dsBackground)
}
#endif
