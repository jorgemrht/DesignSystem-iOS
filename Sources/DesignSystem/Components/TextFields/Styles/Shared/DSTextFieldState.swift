import SwiftUI

public enum DSTextFieldState: Sendable, CaseIterable {
  case normal
  case focused
  case error
}

extension DSTextFieldState {
  func resolved(isFocused: Bool) -> DSTextFieldState {
    self == .error ? .error : (isFocused ? .focused : self)
  }

  var lineWidth: CGFloat {
    self == .focused ? 2 : 1
  }
}
