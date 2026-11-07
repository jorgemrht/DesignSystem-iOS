import SwiftUI

public enum DSTextFieldState: Sendable, CaseIterable {
  case normal
  case focused
  case error
}

extension DSTextFieldState {
  init(_ result: DSValidationResult?) {
    self = result.isInvalid ? .error : .normal
  }

  private func resolved(isFocused: Bool) -> DSTextFieldState {
    self == .error ? .error : (isFocused ? .focused : self)
  }

  func resolved(isFocused: Bool, in context: DSFieldContext?) -> DSTextFieldState {
    let state = self == .normal ? DSTextFieldState(context?.result) : self
    return state.resolved(isFocused: context?.isFocused(local: isFocused) ?? isFocused)
  }

  var lineWidth: CGFloat {
    self == .focused ? 2 : 1
  }
}
