import JDesignSystem
import SwiftUI

struct BannersShowcase: View {
  @State private var style: DSBannerStyle? = .error
  @State private var showsClose = true

  var body: some View {
    ShowcasePage {
      Picker("Banner", selection: $style) {
        Text(verbatim: "None").tag(DSBannerStyle?.none)
        Text(verbatim: "Success").tag(DSBannerStyle?.some(.success))
        Text(verbatim: "Warning").tag(DSBannerStyle?.some(.warning))
        Text(verbatim: "Error").tag(DSBannerStyle?.some(.error))
        Text(verbatim: "Info").tag(DSBannerStyle?.some(.info))
      }
      .showcaseSegmentedPicker()

      Toggle(isOn: $showsClose) { Text(verbatim: "Close button (optional)") }

      Text(verbatim: "The banner stays anchored to the bottom of the screen.")
        .foregroundStyle(.dsOnSurfaceVariant)
    }
    .safeAreaInset(edge: .bottom, spacing: 0) {
      if let style {
        banner(for: style)
      }
    }
  }

  @ViewBuilder
  private func banner(for style: DSBannerStyle) -> some View {
    if showsClose {
      DSBanner(
        message(for: style),
        systemSymbol: symbol(for: style),
        style: style
      ) {
        self.style = nil
      }
    } else {
      DSBanner(message(for: style), systemSymbol: symbol(for: style), style: style)
    }
  }

  private func message(for style: DSBannerStyle) -> LocalizedStringResource {
    switch style {
    case .success: "Changes saved"
    case .warning: "Your session is about to expire"
    case .error: "No connection"
    case .info: "Version 2.0 available"
    }
  }

  private func symbol(for style: DSBannerStyle) -> DSSystemSymbol {
    switch style {
    case .success: .success
    case .warning: .warning
    case .error: .offline
    case .info: .info
    }
  }
}

struct LoadingShowcase: View {
  @State private var showsLoading = false
  @State private var showsLoadingWithMessage = false

  var body: some View {
    ShowcasePage {
      Toggle(isOn: $showsLoading) { Text(verbatim: "Loading") }
      Toggle(isOn: $showsLoadingWithMessage) { Text(verbatim: "Loading with message") }

      Text(verbatim: "Screen content")
        .frame(maxWidth: .infinity, minHeight: 240)
        .background(.dsSurface, in: .rect(cornerRadius: .cornerRadiusL))
        .dsLoading(showsLoading || showsLoadingWithMessage, message: showsLoadingWithMessage ? "Loading…" : nil)
    }
  }
}

struct ProgressShowcase: View {
  @State private var fraction = 0.6

  var body: some View {
    ShowcasePage {
      ShowcaseGroup(title: "Linear") {
        ProgressView(value: fraction) { Text(verbatim: "Uploading") } currentValueLabel: {
          Text(fraction, format: .percent.precision(.fractionLength(0)))
        }
        .progressViewStyle(.dsLinear)
      }

      ShowcaseGroup(title: "Circular") {
        ProgressView(value: fraction) { Text(verbatim: "Syncing") }
          .progressViewStyle(.dsCircular)
      }

      ShowcaseGroup(title: "Indeterminate") {
        ProgressView { Text(verbatim: "Loading") }
          .progressViewStyle(.dsCircular)
        ProgressView()
          .progressViewStyle(.dsLinear)
      }

      #if !os(tvOS)
      Slider(value: $fraction, in: 0 ... 1) { Text(verbatim: "Progress") }
      #endif
    }
  }
}

struct AppUpdateShowcase: View {
  @State private var update: DSAppUpdate?

  private let texts = DSUpdateAppTexts(
    title: "Update available",
    message: "Update the app to get the latest improvements.",
    updateButtonTitle: "Update",
    dismissButtonTitle: "Not now"
  )

  private static let storeURL = URL(string: "https://apps.apple.com")!

  var body: some View {
    ShowcasePage {
      Button("Show optional") {
        update = DSAppUpdate(force: false, url: Self.storeURL)
      }
      .buttonStyle(.dsBordered)
      .buttonSizing(.flexible)

      Button("Show forced") {
        update = DSAppUpdate(force: true, url: Self.storeURL)
      }
      .buttonStyle(.dsPrimary)
      .buttonSizing(.flexible)
    }
    .dsUpdateApp(
      appUpdate: update,
      texts: texts,
      systemSymbol: .update,
      openURLAction: { update = nil },
      dismissAction: { update = nil }
    )
  }
}
