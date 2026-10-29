import SwiftUI

struct DSTextFieldAccessoryView: View {
  let accessory: DSTextFieldAccessory
  let appearance: DSTextFieldAppearance

  @Environment(\.isEnabled) private var isEnabled

  var body: some View {
    switch accessory {
    case let .clearButton(title, systemSymbol, isVisible, action):
      Button(title, systemImage: systemSymbol.rawValue) {
        action()
      }
      .labelStyle(.iconOnly)
      .buttonStyle(.plain)
      .frame(minWidth: 44, minHeight: 44)
      .foregroundStyle(appearance.promptColor(isEnabled: isEnabled))
      .opacity(isVisible ? 1 : 0)
      .disabled(!isVisible)

    case let .systemImage(systemSymbol):
      Image(systemSymbol: systemSymbol)
        .foregroundStyle(appearance.promptColor(isEnabled: isEnabled))
        .accessibilityHidden(true)

    case let .button(title, systemSymbol, action):
      Button(title, systemImage: systemSymbol.rawValue, action: action)
        .labelStyle(.iconOnly)
        .buttonStyle(.plain)
        .frame(minWidth: 44, minHeight: 44)
        .foregroundStyle(appearance.promptColor(isEnabled: isEnabled))

    case let .text(text):
      Text(text)
        .font(.body)
        .foregroundStyle(appearance.promptColor(isEnabled: isEnabled))
    }
  }
}
