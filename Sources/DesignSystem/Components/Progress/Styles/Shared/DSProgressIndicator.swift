import SwiftUI

struct DSProgressMetrics: Equatable {
  let scale: CGFloat
  var controlSize: ControlSize = .regular

  var circularDiameter: CGFloat {
    let base: CGFloat = switch controlSize {
    case .mini: 16
    case .small: 24
    case .regular: 40
    case .large: 56
    case .extraLarge: 72
    @unknown default: 40
    }
    return base * scale
  }

  var lineWidth: CGFloat {
    4 * scale
  }

  static func clamped(_ fraction: Double) -> Double {
    fraction.isNaN ? 0 : min(max(fraction, 0), 1)
  }
}

private struct DSFractionAnimation: ViewModifier {
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  let fraction: Double

  func body(content: Content) -> some View {
    content.animation(reduceMotion ? nil : .default, value: fraction)
  }
}

struct DSCircularProgressIndicator: View {
  let fraction: Double
  let metrics: DSProgressMetrics
  let appearance: DSProgressAppearance

  var body: some View {
    ZStack {
      Circle()
        .stroke(appearance.track, lineWidth: metrics.lineWidth)
      Circle()
        .trim(from: 0, to: fraction)
        .stroke(appearance.indicator, style: StrokeStyle(lineWidth: metrics.lineWidth, lineCap: .round))
        .rotationEffect(.degrees(-90))
    }
    .padding(metrics.lineWidth / 2)
    .frame(width: metrics.circularDiameter, height: metrics.circularDiameter)
    .modifier(DSFractionAnimation(fraction: fraction))
  }
}

private struct DSLinearTrack<Fill: View>: View {
  let metrics: DSProgressMetrics
  let appearance: DSProgressAppearance
  @ViewBuilder let fill: (_ trackWidth: CGFloat) -> Fill

  var body: some View {
    Capsule()
      .fill(appearance.track)
      .overlay(alignment: .leading) {
        GeometryReader { proxy in
          fill(proxy.size.width)
        }
      }
      .clipShape(Capsule())
      .frame(height: metrics.lineWidth)
  }
}

struct DSLinearProgressIndicator: View {
  let fraction: Double
  let metrics: DSProgressMetrics
  let appearance: DSProgressAppearance

  var body: some View {
    DSLinearTrack(metrics: metrics, appearance: appearance) { width in
      Capsule()
        .fill(appearance.indicator)
        .frame(width: width * fraction)
    }
    .modifier(DSFractionAnimation(fraction: fraction))
  }
}

struct DSIndeterminateLinearIndicator: View {
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  let metrics: DSProgressMetrics
  let appearance: DSProgressAppearance

  var body: some View {
    DSLinearTrack(metrics: metrics, appearance: appearance) { width in
      let segment = width * 0.4
      let travel = width + segment
      let capsule = Capsule()
        .fill(appearance.indicator)
        .frame(width: segment)

      if reduceMotion {
        capsule.offset(x: (width - segment) / 2)
      } else {
        capsule.phaseAnimator([0.0, 1.0]) { content, phase in
          content.offset(x: travel * phase - segment)
        } animation: { phase in
          phase == 1 ? .linear(duration: 1.2) : nil
        }
      }
    }
  }
}
