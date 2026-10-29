import SwiftUI

public struct DSTextFieldAppearance: Sendable {
  public let text: Color
  public let prompt: Color
  public let label: Color
  public let helper: Color
  public let container: Color
  public let outlinedContainer: Color
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
    outlinedContainer: Color = .dsSurface,
    indicator: Color,
    focusedIndicator: Color,
    error: Color,
    disabledContent: Color = .dsOnSurface.opacity(.opacityDisabled),
    disabledContainer: Color = .dsOnSurface.opacity(.opacityDisabledFill),
    disabledFilledIndicator: Color = .dsOnSurface.opacity(.opacityDisabled),
    disabledOutlinedIndicator: Color = .dsOnSurface.opacity(.opacityDisabledSubtle)
  ) {
    self.text = text
    self.prompt = prompt
    self.label = label
    self.helper = helper
    self.container = container
    self.outlinedContainer = outlinedContainer
    self.indicator = indicator
    self.focusedIndicator = focusedIndicator
    self.error = error
    self.disabledContent = disabledContent
    self.disabledContainer = disabledContainer
    self.disabledFilledIndicator = disabledFilledIndicator
    self.disabledOutlinedIndicator = disabledOutlinedIndicator
  }

  public static let standard = tinted(.dsPrimary)

  public static func tinted(_ color: Color) -> Self {
    Self(
      text: .dsOnSurface,
      prompt: .dsOnSurfaceVariant,
      label: .dsOnSurfaceVariant,
      helper: .dsOnSurfaceVariant,
      container: .dsSurfaceVariant,
      indicator: .dsOutline,
      focusedIndicator: color,
      error: .dsError
    )
  }

  func labelColor(state: DSTextFieldState, isEnabled: Bool) -> Color {
    guard isEnabled else { return disabledContent }
    return state == .error ? error : label
  }

  func supportColor(state: DSTextFieldState, isEnabled: Bool) -> Color {
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
    state: DSTextFieldState,
    isEnabled: Bool,
    variant: DSTextFieldVariant
  ) -> Color {
    guard isEnabled else {
      switch variant {
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
