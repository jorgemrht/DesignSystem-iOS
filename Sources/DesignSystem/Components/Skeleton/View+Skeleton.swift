import SwiftUI

public extension View {
  func dsSkeleton(_ isLoading: Bool, appearance: DSSkeletonAppearance = .standard) -> some View {
    modifier(DSSkeletonModifier(isLoading: isLoading, appearance: appearance))
  }
}

private struct DSSkeletonModifier: ViewModifier {
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  let isLoading: Bool
  let appearance: DSSkeletonAppearance

  func body(content: Content) -> some View {
    if isLoading {
      placeholder(content)
    } else {
      content
    }
  }

  @ViewBuilder
  private func placeholder(_ content: Content) -> some View {
    let redacted = content
      .redacted(reason: .placeholder)
      .grayscale(1)
      .colorMultiply(appearance.tint ?? .white)
      .disabled(true)
      .accessibilityHidden(true)

    if reduceMotion {
      redacted
    } else {
      redacted.phaseAnimator([0.0, 2.0]) { view, phase in
        view.mask { DSSkeletonShimmer(phase: phase) }
      } animation: { phase in
        phase == 2 ? .linear(duration: 1.4) : nil
      }
    }
  }
}

private struct DSSkeletonShimmer: View {
  let phase: Double

  var body: some View {
    LinearGradient(
      colors: [.black.opacity(.skeletonDim), .black, .black.opacity(.skeletonDim)],
      startPoint: UnitPoint(x: phase - 1, y: 0.5),
      endPoint: UnitPoint(x: phase, y: 0.5)
    )
  }
}

private extension Double {
  static let skeletonDim: Double = 0.4
}

#if DEBUG
#Preview("Skeleton") {
  VStack(spacing: .spacingS) {
    ForEach(0 ..< 3, id: \.self) { _ in
      VStack(alignment: .leading, spacing: .spacingXXS) {
        Text(verbatim: "Placeholder title")
          .font(.headline)
        Text(verbatim: "Placeholder subtitle for the row")
          .foregroundStyle(.dsOnSurfaceVariant)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .dsCard(.outlined)
    }
  }
  .padding(.spacingS)
  .dsSkeleton(true)
}
#endif
