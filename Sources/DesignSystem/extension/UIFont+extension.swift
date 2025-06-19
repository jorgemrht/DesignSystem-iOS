import SwiftUI

public enum FontSize: String, CaseIterable {
  /// Large Title — 34 pt
  case largeTitle = "Large Title"
  /// Title1 — 28 pt
  case title = "Title"
  /// Title2 — 22 pt
  case title2 = "Title2"
  /// Title3 — 20 pt
  case title3 = "Title3"
  /// Headline — 17 pt
  case headline = "Headline"
  /// Body — 17 pt
  case body = "Body"
  /// Callout — 16 pt
  case callout = "Callout"
  /// Subheadline — 15 pt
  case subheadline = "Subheadline"
  /// Footnote — 13 pt
  case footnote = "Footnote"
  /// Caption1 — 12 pt
  case caption = "Caption1"
  /// Caption2 — 11 pt
  case caption2 = "Caption2"

  public var textStyle: Font.TextStyle {
    switch self {
    case .largeTitle: return .largeTitle
    case .title: return .title
    case .title2: return .title2
    case .title3: return .title3
    case .headline: return .headline
    case .body: return .body
    case .callout: return .callout
    case .subheadline: return .subheadline
    case .footnote: return .footnote
    case .caption: return .caption
    case .caption2: return .caption2
    }
  }
}

extension View {
  public func font(size: FontSize, weight: Font.Weight = .regular) -> some View {
    self
      .font(.system(size.textStyle, design: .default))
      .fontWeight(weight)
  }
}
