import SwiftUI

public extension View {
  func dsUpdateApp(
    appUpdate: DSAppUpdate?,
    texts: DSUpdateAppTexts,
    systemSymbol: DSSystemSymbol,
    openURLAction: @escaping @MainActor () -> Void,
    dismissAction: @escaping @MainActor () -> Void
  ) -> some View {
    modifier(
      DSUpdateAppModifier(
        appUpdate: appUpdate,
        texts: texts,
        systemSymbol: systemSymbol,
        openURLAction: openURLAction,
        dismissAction: dismissAction
      )
    )
  }
}

private struct DSUpdateAppModifier: ViewModifier {
  private let appUpdate: DSAppUpdate?
  private let texts: DSUpdateAppTexts
  private let systemSymbol: DSSystemSymbol
  private let openURLAction: @MainActor () -> Void
  private let dismissAction: @MainActor () -> Void

  init(
    appUpdate: DSAppUpdate?,
    texts: DSUpdateAppTexts,
    systemSymbol: DSSystemSymbol,
    openURLAction: @escaping @MainActor () -> Void,
    dismissAction: @escaping @MainActor () -> Void
  ) {
    self.appUpdate = appUpdate
    self.texts = texts
    self.systemSymbol = systemSymbol
    self.openURLAction = openURLAction
    self.dismissAction = dismissAction
  }

  func body(content: Content) -> some View {
    ZStack {
      content
        .accessibilityHidden(appUpdate != nil)
      if let appUpdate {
        DSUpdateAppView(
          appUpdate: appUpdate,
          texts: texts,
          systemSymbol: systemSymbol,
          openURLAction: openURLAction,
          dismissAction: dismissAction
        )
      }
    }
  }
}
