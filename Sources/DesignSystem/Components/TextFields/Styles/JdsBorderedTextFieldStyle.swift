import SwiftUI

public extension TextFieldStyle where Self == JdsTextFieldStyle {
  static var JdsBorderedTextField: Self {
    .init(presentation: .bordered)
  }

  static func JdsBorderedTextField(
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
      presentation: .bordered,
      state: state,
      cornerRadius: cornerRadius
    )
  }
}
