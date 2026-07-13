import SwiftUI

public struct JdsTextFieldAppearance: Sendable {
  public let text: Color
  public let prompt: Color
  public let label: Color
  public let helper: Color
  public let container: Color
  public let indicator: Color
  public let focusedIndicator: Color
  public let error: Color
  public let disabledContent: Color
  public let disabledContainer: Color
  public let disabledFilledIndicator: Color
  public let disabledOutlinedIndicator: Color

  public init(
    text: Color,
    prompt: Color,
    label: Color,
    helper: Color,
    container: Color,
    indicator: Color,
    focusedIndicator: Color,
    error: Color,
    disabledContent: Color = .dsOnSurface.opacity(0.38),
    disabledContainer: Color = .dsOnSurface.opacity(0.04),
    disabledFilledIndicator: Color = .dsOnSurface.opacity(0.38),
    disabledOutlinedIndicator: Color = .dsOnSurface.opacity(0.12)
  ) {
    self.text = text
    self.prompt = prompt
    self.label = label
    self.helper = helper
    self.container = container
    self.indicator = indicator
    self.focusedIndicator = focusedIndicator
    self.error = error
    self.disabledContent = disabledContent
    self.disabledContainer = disabledContainer
    self.disabledFilledIndicator = disabledFilledIndicator
    self.disabledOutlinedIndicator = disabledOutlinedIndicator
  }

  public static let standard = JdsTextFieldAppearance(
    text: .dsOnSurface,
    prompt: .dsOnSurfaceVariant,
    label: .dsOnSurfaceVariant,
    helper: .dsOnSurfaceVariant,
    container: .dsSurfaceVariant,
    indicator: .dsOutline,
    focusedIndicator: .dsPrimary,
    error: .dsError
  )

  func labelColor(state: JdsTextFieldState, isEnabled: Bool) -> Color {
    guard isEnabled else { return disabledContent }
    return state == .error ? error : label
  }

  func supportColor(state: JdsTextFieldState, isEnabled: Bool) -> Color {
    guard isEnabled else { return disabledContent }
    return state == .error ? error : helper
  }

  func contentColor(isEnabled: Bool) -> Color {
    isEnabled ? text : disabledContent
  }

  func promptColor(isEnabled: Bool) -> Color {
    isEnabled ? prompt : disabledContent
  }

  func containerColor(isEnabled: Bool) -> Color {
    isEnabled ? container : disabledContainer
  }

  func outlineColor(
    state: JdsTextFieldState,
    isEnabled: Bool,
    presentation: JdsTextFieldPresentation
  ) -> Color {
    guard isEnabled else {
      switch presentation {
      case .plain:
        return .clear
      case .tinted, .underlined:
        return disabledFilledIndicator
      case .bordered:
        return disabledOutlinedIndicator
      }
    }

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
