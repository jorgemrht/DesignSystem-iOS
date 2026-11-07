import SwiftUI

enum DSFieldFocus: Equatable {
  case local
  case external(isFocused: Bool)
}

struct DSFieldContext: Equatable {
  let result: DSValidationResult?
  let focus: DSFieldFocus

  var ownsFocus: Bool {
    focus != .local
  }

  func isFocused(local: Bool) -> Bool {
    switch focus {
    case .local: local
    case let .external(isFocused): isFocused
    }
  }
}

extension DSFieldContext? {
  var validationMessage: LocalizedStringResource? {
    self?.result?.message
  }
}

extension View {
  func dsFieldContext(result: DSValidationResult?, focus: DSFieldFocus) -> some View {
    environment(\.dsFieldContext, DSFieldContext(result: result, focus: focus))
  }
}

extension EnvironmentValues {
  @Entry var dsFieldContext: DSFieldContext?
}
