import SwiftUI

public struct DSFormStyle: FormStyle {
  public init() {}

  public func makeBody(configuration: Configuration) -> some View {
    ScrollView {
      VStack(alignment: .leading, spacing: .spacingM) {
        Group(sections: configuration.content) { sections in
          ForEach(sections) { section in
            VStack(alignment: .leading, spacing: .spacingXXS) {
              ForEach(subviews: section.header) { header in
                header
                  .font(.subheadline)
                  .foregroundStyle(.dsOnSurfaceVariant)
                  .accessibilityAddTraits(.isHeader)
              }

              VStack(alignment: .leading, spacing: .spacingS) {
                section.content
              }
              .frame(maxWidth: .infinity, alignment: .leading)
              .dsCard()

              section.footer
                .font(.caption)
                .foregroundStyle(.dsOnSurfaceVariant)
            }
          }
        }
      }
      .padding(.spacingS)
    }
    .tint(.dsPrimary)
    .background(.dsBackground)
  }
}

public extension FormStyle where Self == DSFormStyle {
  static var ds: DSFormStyle {
    DSFormStyle()
  }
}
