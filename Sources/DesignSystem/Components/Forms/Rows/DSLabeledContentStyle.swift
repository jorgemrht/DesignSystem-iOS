import SwiftUI

public struct DSLabeledContentStyle: LabeledContentStyle {
  private let disclosure: DSSystemSymbol?

  public init(disclosure: DSSystemSymbol? = nil) {
    self.disclosure = disclosure
  }

  public func makeBody(configuration: Configuration) -> some View {
    DSFormRow {
      configuration.label
    } trailing: {
      HStack(spacing: .spacingXS) {
        configuration.content
          .font(.body)
          .foregroundStyle(.dsOnSurfaceVariant)

        if let disclosure {
          Image(systemSymbol: disclosure)
            .font(.footnote.weight(.semibold))
            .foregroundStyle(.dsOnSurfaceVariant)
            .accessibilityHidden(true)
        }
      }
    }
  }
}

public extension LabeledContentStyle where Self == DSLabeledContentStyle {
  static var ds: DSLabeledContentStyle {
    DSLabeledContentStyle()
  }

  static func ds(disclosure: DSSystemSymbol) -> DSLabeledContentStyle {
    DSLabeledContentStyle(disclosure: disclosure)
  }
}
