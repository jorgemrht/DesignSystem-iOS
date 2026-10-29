import SwiftUI

public extension View {
  func dsListBackgroundColor(_ color: Color) -> some View {
    #if os(tvOS)
    background(color)
    #else
    scrollContentBackground(.hidden)
      .background(color)
    #endif
  }
}

#if DEBUG
#Preview {
  Form {
    Section {
      Text(verbatim: "Primary surface")
        .foregroundStyle(.dsOnSurface)

      Text(verbatim: "Secondary surface")
        .foregroundStyle(.dsOnSurfaceVariant)
    }
  }
  .dsListBackgroundColor(.dsSurface)
}
#endif
