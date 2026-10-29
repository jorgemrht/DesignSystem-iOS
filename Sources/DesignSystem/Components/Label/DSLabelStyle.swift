import SwiftUI

public struct DSLabelStyle: LabelStyle {
  let iconEdge: HorizontalEdge
  let spacing: CGFloat

  public func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: spacing) {
      switch iconEdge {
      case .leading:
        configuration.icon
        configuration.title
      case .trailing:
        configuration.title
        configuration.icon
      }
    }
  }
}

public extension LabelStyle where Self == DSLabelStyle {
  static var dsLabel: Self {
    .init(iconEdge: .leading, spacing: .spacingXXS)
  }

  static func dsLabel(iconEdge: HorizontalEdge = .leading, spacing: CGFloat = .spacingXXS) -> Self {
    .init(iconEdge: iconEdge, spacing: spacing)
  }
}

#if DEBUG
private extension DSSystemSymbol {
  static let star = Self("star")
  static let chevron = Self("chevron.right")
}

#Preview("Labels") {
  VStack(alignment: .leading, spacing: .spacingS) {
    Label { Text(verbatim: "Leading icon") } icon: { Image(systemSymbol: .star) }
      .labelStyle(.dsLabel)
    Label { Text(verbatim: "Trailing icon") } icon: { Image(systemSymbol: .chevron) }
      .labelStyle(.dsLabel(iconEdge: .trailing))
  }
  .padding(.spacingS)
}
#endif
