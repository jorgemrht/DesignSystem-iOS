import SwiftUI

public extension TextFieldStyle where Self == JdsTextFieldStyle {
  static var JdsTintedTextField: Self {
    .init(presentation: .tinted)
  }

  static func JdsTintedTextField(
    title: String? = nil,
    message: String? = nil,
    symbol: JdsSystemSymbol? = nil,
    state: JdsTextFieldState = .normal
  ) -> Self {
    .init(
      title: title,
      message: message,
      symbol: symbol,
      presentation: .tinted,
      state: state
    )
  }
}
