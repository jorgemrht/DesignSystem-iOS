import SwiftUI

public struct DSDivider: View {
  private let color: Color

  public init(color: Color = .dsOutlineVariant) {
    self.color = color
  }

  public var body: some View {
    Divider()
      .overlay(color)
  }
}

#if DEBUG
#Preview("Dividers") {
  VStack(spacing: .spacingS) {
    Text(verbatim: "Above")
    DSDivider()
    HStack(spacing: .spacingS) {
      Text(verbatim: "Leading")
      DSDivider()
      Text(verbatim: "Trailing")
    }
    .fixedSize(horizontal: false, vertical: true)
  }
  .padding(.spacingS)
  .background(.dsBackground)
}
#endif
