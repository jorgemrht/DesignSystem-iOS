import SwiftUI

public enum DSBannerStyle: Sendable, CaseIterable {
  case success
  case warning
  case error
  case info
}

public extension View {
  func dsBannerStyle(_ style: DSBannerStyle) -> some View {
    modifier(DSBannerStyleModifier(style: style))
  }
}

private struct DSBannerStyleModifier: ViewModifier {
  let style: DSBannerStyle

  func body(content: Content) -> some View {
    content
      .dsKeepsClearOfFold()
      .font(.body.weight(.semibold))
      .foregroundStyle(style.foreground)
      .background(style.background, ignoresSafeAreaEdges: [.bottom, .horizontal])
  }
}

extension DSBannerStyle {
  var foreground: Color {
    switch self {
    case .success: .dsOnTertiaryContainer
    case .warning: .dsOnSecondaryContainer
    case .error: .dsOnError
    case .info: .dsOnPrimaryContainer
    }
  }

  var background: Color {
    switch self {
    case .success: .dsTertiaryContainer
    case .warning: .dsSecondaryContainer
    case .error: .dsError
    case .info: .dsPrimaryContainer
    }
  }
}
