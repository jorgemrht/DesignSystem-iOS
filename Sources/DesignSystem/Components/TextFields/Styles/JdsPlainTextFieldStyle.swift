import SwiftUI

public extension TextFieldStyle where Self == JdsTextFieldStyle {
  static var JdsPlainTextField: Self {
    .init(presentation: .plain)
  }

  static func JdsPlainTextField(
    title: String? = nil,
    message: String? = nil,
    symbol: JdsSystemSymbol? = nil,
    state: JdsTextFieldState = .normal
  ) -> Self {
    .init(
      title: title,
      message: message,
      symbol: symbol,
      presentation: .plain,
      state: state
    )
  }
}
