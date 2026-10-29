import SwiftUI

#if !os(visionOS)

public struct DSGlassButtonGroup<Content: View>: View {
  private let spacing: CGFloat?
  private let content: Content

  public init(
    spacing: CGFloat? = .spacingS,
    @ViewBuilder content: () -> Content
  ) {
    self.spacing = spacing
    self.content = content()
  }

  public var body: some View {
    GlassEffectContainer(spacing: spacing) {
      content
    }
  }
}
#endif
