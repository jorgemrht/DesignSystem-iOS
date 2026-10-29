import SwiftUI

public extension View {
  func dsScreenScroll() -> some View {
    modifier(DSScreenScrollModifier())
  }
}

private struct DSScreenScrollModifier: ViewModifier {
  func body(content: Content) -> some View {
    GeometryReader { proxy in
      ScrollView {
        content
          .frame(minHeight: proxy.size.height, alignment: .top)
      }
      .scrollBounceBehavior(.basedOnSize)
    }
  }
}

#if DEBUG
#Preview("Short content") {
  VStack {
    Text(verbatim: "Title")
      .font(.largeTitle)
    Spacer()
    Button("Continue") {}
      .buttonStyle(.dsPrimary)
  }
  .padding(.spacingS)
  .dsScreenScroll()
}

#Preview("Long content") {
  VStack(spacing: .spacingS) {
    ForEach(0 ..< 30, id: \.self) { index in
      Text(verbatim: "Row \(index + 1)")
        .frame(maxWidth: .infinity, alignment: .leading)
        .dsCard()
    }
  }
  .padding(.spacingS)
  .dsScreenScroll()
}
#endif
