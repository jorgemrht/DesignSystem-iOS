import SwiftUI

public enum JdsTextFieldState: Sendable {
  case normal
  case focused
  case error
}

struct TextFieldAppearance: Sendable {
  let text: Color
  let prompt: Color
  let label: Color
  let helper: Color
  let container: Color
  let indicator: Color
  let focusedIndicator: Color
  let error: Color

  static let standard = TextFieldAppearance(
    text: .dsOnSurface,
    prompt: .dsOnSurfaceVariant,
    label: .dsOnSurfaceVariant,
    helper: .dsOnSurfaceVariant,
    container: .dsSurfaceContainerHigh,
    indicator: .dsOutline,
    focusedIndicator: .dsPrimary,
    error: .dsError
  )

  func labelColor(state: JdsTextFieldState, isEnabled: Bool) -> Color {
    guard isEnabled else { return .dsOnSurface.opacity(0.38) }
    return state == .error ? error : label
  }

  func supportColor(state: JdsTextFieldState, isEnabled: Bool) -> Color {
    guard isEnabled else { return .dsOnSurface.opacity(0.38) }
    return state == .error ? error : helper
  }

  func contentColor(isEnabled: Bool) -> Color {
    isEnabled ? text : .dsOnSurface.opacity(0.38)
  }

  func containerColor(isEnabled: Bool) -> Color {
    isEnabled ? container : .dsOnSurface.opacity(0.08)
  }

  func outlineColor(state: JdsTextFieldState, isEnabled: Bool) -> Color {
    guard isEnabled else { return .dsOnSurface.opacity(0.12) }

    switch state {
    case .normal:
      return indicator
    case .focused:
      return focusedIndicator
    case .error:
      return error
    }
  }
}

struct TextFieldSupportText: View {
  let message: String?
  let state: JdsTextFieldState
  let appearance: TextFieldAppearance

  @Environment(\.isEnabled) private var isEnabled

  var body: some View {
    if let message {
      Text(message)
        .font(.caption)
        .foregroundStyle(appearance.supportColor(state: state, isEnabled: isEnabled))
        .accessibilityLabel(state == .error ? "Error: \(message)" : message)
    }
  }
}
