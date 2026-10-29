import SwiftUI

public extension View {
  func dsLoading(_ isLoading: Bool, message: LocalizedStringResource? = nil) -> some View {
    modifier(DSLoadingModifier(isLoading: isLoading, message: message))
  }
}

private struct DSLoadingModifier: ViewModifier {
  let isLoading: Bool
  let message: LocalizedStringResource?

  func body(content: Content) -> some View {
    content
      .disabled(isLoading)
      .accessibilityHidden(isLoading)
      .overlay {
        ZStack {
          if isLoading {
            ZStack {
              Color.dsScrim.opacity(0.12)
                .contentShape(.rect)

              indicator
            }
            .transition(.opacity)
          }
        }
        .animation(.default, value: isLoading)
      }
  }

  private var indicator: some View {
    progress
      .progressViewStyle(.dsCircular(appearance: .tinted(.dsOnSurfaceVariant)))
      .dsCard(.elevated)
  }

  @ViewBuilder
  private var progress: some View {
    if let message {
      ProgressView {
        Text(message)
      }
    } else {
      ProgressView()
    }
  }
}

#if DEBUG
#Preview("Loading with message") {
  Text(verbatim: "Screen content")
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .dsLoading(true, message: "Loading…")
}

#Preview("Loading") {
  Text(verbatim: "Screen content")
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .dsLoading(true)
}
#endif
