import SwiftUI

public struct DSSystemSymbol: RawRepresentable, Sendable, Hashable {
  public let rawValue: String

  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  public init(_ rawValue: String) {
    self.rawValue = rawValue
  }
}

public extension Image {
  init(systemSymbol: DSSystemSymbol) {
    self.init(systemName: systemSymbol.rawValue)
  }
}

public extension Label where Title == Text, Icon == Image {
  init(_ titleKey: LocalizedStringKey, systemSymbol: DSSystemSymbol) {
    self.init(titleKey, systemImage: systemSymbol.rawValue)
  }

  @_disfavoredOverload
  init(_ titleResource: LocalizedStringResource, systemSymbol: DSSystemSymbol) {
    self.init(titleResource, systemImage: systemSymbol.rawValue)
  }
}

public extension Button where Label == SwiftUI.Label<Text, Image> {
  init(
    _ titleResource: LocalizedStringResource,
    systemSymbol: DSSystemSymbol,
    role: ButtonRole? = nil,
    action: @escaping @MainActor () -> Void
  ) {
    self.init(titleResource, systemImage: systemSymbol.rawValue, role: role, action: action)
  }
}

public extension Tab where Value: Hashable, Content: View, Label == DefaultTabLabel {
  init(
    _ titleKey: LocalizedStringKey,
    systemSymbol: DSSystemSymbol,
    value: Value,
    @ViewBuilder content: () -> Content
  ) {
    self.init(titleKey, systemImage: systemSymbol.rawValue, value: value, content: content)
  }
}
