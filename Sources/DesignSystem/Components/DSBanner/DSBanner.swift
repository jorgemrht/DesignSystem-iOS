import SwiftUI

public struct DSBanner: View {
  private let message: LocalizedStringResource
  private let systemSymbol: DSSystemSymbol?
  private let style: DSBannerStyle
  private let onDismiss: (@MainActor () -> Void)?

  public init(
    _ message: LocalizedStringResource,
    systemSymbol: DSSystemSymbol? = nil,
    style: DSBannerStyle
  ) {
    self.message = message
    self.systemSymbol = systemSymbol
    self.style = style
    onDismiss = nil
  }

  public init(
    _ message: LocalizedStringResource,
    systemSymbol: DSSystemSymbol? = nil,
    style: DSBannerStyle,
    onDismiss: @escaping @MainActor () -> Void
  ) {
    self.message = message
    self.systemSymbol = systemSymbol
    self.style = style
    self.onDismiss = onDismiss
  }

  public var body: some View {
    HStack(spacing: .spacingXXS) {
      if let systemSymbol {
        Image(systemSymbol: systemSymbol)
          .accessibilityHidden(true)
      }
      Text(message)
    }
    .multilineTextAlignment(.center)
    .padding(.horizontal, isDismissible ? .controlSizeS : .spacingS)
    .frame(maxWidth: .infinity, minHeight: isDismissible ? .controlSizeL : .controlSizeM)
    .overlay(alignment: .trailing) {
      if let onDismiss {
        dismissButton(onDismiss)
          .padding(.trailing, .spacingXS)
      }
    }
    .dsBannerStyle(style)
  }

  private var isDismissible: Bool {
    onDismiss != nil
  }

  @ViewBuilder
  private func dismissButton(_ action: @escaping @MainActor () -> Void) -> some View {
    let button = Button(role: .close, action: action)
    #if os(visionOS)
    button.buttonStyle(.dsIcon(prominence: .plain, size: .small, appearance: .plain(style.foreground)))
    #else
    button.buttonStyle(.dsGlassIcon(size: .small, appearance: .plain(style.foreground)))
    #endif
  }
}

#if DEBUG
private extension DSSystemSymbol {
  static let success = Self("checkmark.circle")
  static let warning = Self("exclamationmark.triangle")
  static let offline = Self("wifi.slash")
  static let info = Self("info.circle")
}

private struct BannerPreviewScreen<Banner: View>: View {
  @ViewBuilder let banner: Banner

  var body: some View {
    Text(verbatim: "Screen content")
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .safeAreaInset(edge: .bottom, spacing: 0) {
        banner
      }
  }
}

#Preview("Success") {
  BannerPreviewScreen {
    DSBanner("Changes saved", systemSymbol: .success, style: .success)
  }
}

#Preview("Warning") {
  BannerPreviewScreen {
    DSBanner("Session about to expire", systemSymbol: .warning, style: .warning)
  }
}

#Preview("Error") {
  BannerPreviewScreen {
    DSBanner(
      "No connection",
      systemSymbol: .offline,
      style: .error
    ) {}
  }
}

#Preview("Info") {
  BannerPreviewScreen {
    DSBanner("Version 2.0 available", systemSymbol: .info, style: .info)
  }
}
#endif
