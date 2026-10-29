import SwiftUI

enum DSProgressVariant: Sendable, CaseIterable {
  case circular
  case linear
}

public struct DSProgressViewStyle: ProgressViewStyle {
  let variant: DSProgressVariant
  let appearance: DSProgressAppearance

  public func makeBody(configuration: Configuration) -> some View {
    DSProgressBody(configuration: configuration, variant: variant, appearance: appearance)
  }
}

public extension ProgressViewStyle where Self == DSProgressViewStyle {
  static var dsCircular: Self {
    .init(variant: .circular, appearance: .standard)
  }

  static func dsCircular(appearance: DSProgressAppearance) -> Self {
    .init(variant: .circular, appearance: appearance)
  }

  static var dsLinear: Self {
    .init(variant: .linear, appearance: .standard)
  }

  static func dsLinear(appearance: DSProgressAppearance) -> Self {
    .init(variant: .linear, appearance: appearance)
  }
}

private struct DSProgressBody: View {
  @Environment(\.controlSize) private var controlSize
  @ScaledMetric(relativeTo: .body) private var scale: CGFloat = 1

  let configuration: ProgressViewStyleConfiguration
  let variant: DSProgressVariant
  let appearance: DSProgressAppearance

  var body: some View {
    let metrics = DSProgressMetrics(scale: scale, controlSize: controlSize)

    let combined = content(metrics: metrics)
      .accessibilityElement(children: .combine)

    if let accessibilityValue {
      combined.accessibilityValue(accessibilityValue)
    } else {
      combined
    }
  }

  @ViewBuilder
  private func content(metrics: DSProgressMetrics) -> some View {
    switch variant {
    case .circular:
      VStack(spacing: .spacingXXS) {
        indicator(metrics: metrics)
        label
        currentValueLabel
      }
    case .linear:
      VStack(spacing: .spacingXXS) {
        if configuration.label != nil || configuration.currentValueLabel != nil {
          HStack(alignment: .firstTextBaseline) {
            label
            Spacer(minLength: .spacingS)
            currentValueLabel
          }
        }
        indicator(metrics: metrics)
      }
    }
  }

  private var accessibilityValue: Text? {
    guard let fraction = configuration.fractionCompleted, configuration.currentValueLabel == nil else {
      return nil
    }
    return Text(DSProgressMetrics.clamped(fraction), format: .percent.precision(.fractionLength(0)))
  }

  @ViewBuilder
  private var label: some View {
    if let label = configuration.label {
      label.foregroundStyle(appearance.label)
    }
  }

  @ViewBuilder
  private var currentValueLabel: some View {
    if let currentValueLabel = configuration.currentValueLabel {
      currentValueLabel
        .font(.footnote)
        .foregroundStyle(appearance.value)
    }
  }

  @ViewBuilder
  private func indicator(metrics: DSProgressMetrics) -> some View {
    switch (variant, configuration.fractionCompleted.map(DSProgressMetrics.clamped)) {
    case (.circular, nil):
      ProgressView()
        .progressViewStyle(.circular)
        .tint(appearance.indicator)
    case (.linear, nil):
      DSIndeterminateLinearIndicator(metrics: metrics, appearance: appearance)
    case let (.circular, fraction?):
      DSCircularProgressIndicator(fraction: fraction, metrics: metrics, appearance: appearance)
    case let (.linear, fraction?):
      DSLinearProgressIndicator(fraction: fraction, metrics: metrics, appearance: appearance)
    }
  }
}

#if DEBUG
private struct ProgressPreviewScreen: View {
  var body: some View {
    VStack(alignment: .leading, spacing: .spacingM) {
      ProgressView(value: 0.6) { Text(verbatim: "Uploading") } currentValueLabel: { Text(verbatim: "60%") }
        .progressViewStyle(.dsLinear)
      ProgressView(value: 0.35) { Text(verbatim: "Syncing") }
        .progressViewStyle(.dsCircular)
      ProgressView { Text(verbatim: "Loading") }
        .progressViewStyle(.dsCircular)
      ProgressView()
        .progressViewStyle(.dsLinear)
    }
    .padding(.spacingS)
    .background(.dsBackground)
  }
}

#Preview("Progress") {
  ProgressPreviewScreen()
}
#endif
