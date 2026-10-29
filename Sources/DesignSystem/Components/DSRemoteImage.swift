import SwiftUI

public struct DSRemoteImage: View {
  private let url: URL
  private let contentMode: ContentMode
  private let failureSymbol: DSSystemSymbol?
  private let accessibilityLabel: LocalizedStringResource?

  public init(
    url: URL,
    contentMode: ContentMode = .fit,
    failureSymbol: DSSystemSymbol? = nil,
    accessibilityLabel: LocalizedStringResource? = nil
  ) {
    self.url = url
    self.contentMode = contentMode
    self.failureSymbol = failureSymbol
    self.accessibilityLabel = accessibilityLabel
  }

  public var body: some View {
    AsyncImage(url: url) { phase in
      switch phase {
      case let .success(image):
        image
          .resizable()
          .aspectRatio(contentMode: contentMode)
      case .failure:
        if let failureSymbol {
          Image(systemSymbol: failureSymbol)
            .font(.largeTitle)
            .foregroundStyle(.dsOnSurfaceVariant)
        }
      case .empty:
        ProgressView()
      @unknown default:
        ProgressView()
      }
    }
    .accessibilityElement(children: .ignore)
    .accessibilityHidden(accessibilityLabel == nil)
    .accessibilityLabel(accessibilityLabel.map { Text($0) } ?? Text(verbatim: ""))
    .accessibilityAddTraits(.isImage)
  }
}

#if DEBUG
private extension DSSystemSymbol {
  static let photo = Self("photo")
}

#Preview {
  DSRemoteImage(
    url: URL(string: "https://example.com/missing.png")!,
    failureSymbol: .photo,
    accessibilityLabel: "Image"
  )
  .frame(width: 120, height: 120)
  .background(.dsSurfaceVariant)
}
#endif
