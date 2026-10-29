import SwiftUI

enum DSToggleVariant: Sendable, CaseIterable {
  case `switch`
  case checkbox
}

public struct DSToggleStyle: ToggleStyle {
  let variant: DSToggleVariant
  let appearance: DSToggleAppearance

  public func makeBody(configuration: Configuration) -> some View {
    Button {
      configuration.isOn.toggle()
    } label: {
      configuration.label
    }
    .buttonStyle(DSToggleButtonStyle(isOn: configuration.isOn, variant: variant, appearance: appearance))
  }
}

public extension ToggleStyle where Self == DSToggleStyle {
  static var dsSwitch: Self {
    .init(variant: .switch, appearance: .standard)
  }

  static func dsSwitch(appearance: DSToggleAppearance) -> Self {
    .init(variant: .switch, appearance: appearance)
  }

  static var dsCheckbox: Self {
    .init(variant: .checkbox, appearance: .standard)
  }

  static func dsCheckbox(appearance: DSToggleAppearance) -> Self {
    .init(variant: .checkbox, appearance: appearance)
  }
}

private struct DSToggleButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.accessibilityReduceMotion) private var reduceMotion
  @ScaledMetric(relativeTo: .body) private var scale: CGFloat = 1

  let isOn: Bool
  let variant: DSToggleVariant
  let appearance: DSToggleAppearance

  func makeBody(configuration: Configuration) -> some View {
    let label = configuration.label
      .foregroundStyle(appearance.labelColor(isEnabled: isEnabled))
      .frame(maxWidth: .infinity, alignment: .leading)
    let state = DSToggleControlState(
      isOn: isOn,
      isPressed: configuration.isPressed,
      isEnabled: isEnabled,
      appearance: appearance,
      scale: scale
    )

    HStack(spacing: .spacingS) {
      switch variant {
      case .switch:
        label
        DSSwitchControl(state: state)
      case .checkbox:
        DSCheckboxControl(state: state)
        label
      }
    }
    .frame(minHeight: .controlSizeS)
    .contentShape(.rect)
    .animation(reduceMotion ? nil : .snappy, value: isOn)
    .animation(reduceMotion ? nil : .snappy, value: configuration.isPressed)
  }
}

#if DEBUG
private struct TogglePreviewScreen: View {
  @State private var isSwitchOn = true
  @State private var isCheckboxOn = true

  var body: some View {
    VStack(spacing: .spacingS) {
      Toggle(isOn: $isSwitchOn) { Text(verbatim: "Notifications") }
        .toggleStyle(.dsSwitch)
      Toggle(isOn: .constant(false)) { Text(verbatim: "Off") }
        .toggleStyle(.dsSwitch)
      Toggle(isOn: .constant(true)) { Text(verbatim: "Disabled on") }
        .toggleStyle(.dsSwitch)
        .disabled(true)
      Toggle(isOn: $isCheckboxOn) { Text(verbatim: "Accept the terms") }
        .toggleStyle(.dsCheckbox)
      Toggle(isOn: .constant(false)) { Text(verbatim: "Disabled off") }
        .toggleStyle(.dsCheckbox)
        .disabled(true)
    }
    .padding(.spacingS)
    .background(.dsBackground)
  }
}

#Preview("Toggles") {
  TogglePreviewScreen()
}
#endif
