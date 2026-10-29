import SwiftUI

public struct DSLoadMoreRow: View {
  private let isLoading: Bool
  private let loadMore: @MainActor () -> Void
  @State private var isVisible = false

  public init(isLoading: Bool, loadMore: @escaping @MainActor () -> Void) {
    self.isLoading = isLoading
    self.loadMore = loadMore
  }

  public var body: some View {
    ZStack {
      if isLoading {
        ProgressView()
          .progressViewStyle(.dsCircular)
      }
    }
    .frame(maxWidth: .infinity, minHeight: .controlSizeS)
    .hidingListRowSeparator()
    .listRowBackground(Color.clear)
    .onAppear {
      isVisible = true
      requestLoadIfNeeded()
    }
    .onDisappear {
      isVisible = false
    }
    .onChange(of: isLoading) {
      requestLoadIfNeeded()
    }
  }
}

extension DSLoadMoreRow {
  static func shouldLoad(isLoading: Bool, isVisible: Bool) -> Bool {
    isVisible && !isLoading
  }

  private func requestLoadIfNeeded() {
    guard Self.shouldLoad(isLoading: isLoading, isVisible: isVisible) else { return }
    loadMore()
  }
}

private extension View {
  func hidingListRowSeparator() -> some View {
    #if os(tvOS) || os(watchOS)
    self
    #else
    listRowSeparator(.hidden)
    #endif
  }
}

#if DEBUG
#Preview("Load more") {
  List {
    ForEach(0 ..< 5, id: \.self) { index in
      Text(verbatim: "Row \(index)")
    }
    DSLoadMoreRow(isLoading: true) {}
  }
}
#endif
