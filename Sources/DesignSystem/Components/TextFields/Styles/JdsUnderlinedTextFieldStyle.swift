import SwiftUI

public extension TextFieldStyle where Self == JdsTextFieldStyle {
  static var JdsUnderlinedTextField: Self {
    .init(presentation: .underlined)
  }

  static func JdsUnderlinedTextField(
    title: String? = nil,
    message: String? = nil,
    symbol: JdsSystemSymbol? = nil,
    state: JdsTextFieldState = .normal,
    cornerRadius: CGFloat = .cornerRadiusM
  ) -> Self {
    .init(
      title: title,
      message: message,
      symbol: symbol,
      presentation: .underlined,
      state: state,
      cornerRadius: cornerRadius
    )
  }
}
