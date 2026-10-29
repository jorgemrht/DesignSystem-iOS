import SwiftUI

public struct DSUpdateAppView: View {
  private let appUpdate: DSAppUpdate
  private let texts: DSUpdateAppTexts
  private let systemSymbol: DSSystemSymbol
  private let openURLAction: @MainActor () -> Void
  private let dismissAction: @MainActor () -> Void

  public init(
    appUpdate: DSAppUpdate,
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

  public var body: some View {
    ContentUnavailableView {
      Label {
        Text(texts.title)
      } icon: {
        Image(systemSymbol: systemSymbol)
      }
    } description: {
      Text(texts.message)
    } actions: {
      Button(action: openURLAction) {
        Text(texts.updateButtonTitle)
      }
      .buttonStyle(.dsPrimary(size: .medium))
      if !appUpdate.force {
        Button(action: dismissAction) {
          Text(texts.dismissButtonTitle)
        }
        .buttonStyle(.dsTertiary(size: .medium))
      }
    }
    .dsKeepsClearOfFold()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.dsBackground)
    .accessibilityAddTraits(.isModal)
  }
}

#if DEBUG
private extension DSSystemSymbol {
  static let update = Self("arrow.down.app")
}

#Preview("Forced") {
  DSUpdateAppView(
    appUpdate: DSAppUpdate(force: true, url: URL(string: "https://apps.apple.com")!),
    texts: .preview,
    systemSymbol: .update,
    openURLAction: {},
    dismissAction: {}
  )
}

#Preview("Optional over content") {
  DSUpdateAppView(
    appUpdate: DSAppUpdate(force: false, url: URL(string: "https://apps.apple.com")!),
    texts: .preview,
    systemSymbol: .update,
    openURLAction: {},
    dismissAction: {}
  )
}

private extension DSUpdateAppTexts {
  static let preview = DSUpdateAppTexts(
    title: "Update available",
    message: "Update the app to get the latest improvements.",
    updateButtonTitle: "Update",
    dismissButtonTitle: "Not now"
  )
}
#endif
