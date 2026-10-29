import SwiftUI

public extension TextFieldStyle where Self == DSTextFieldStyle {
  static var dsBorderedTextField: Self {
    .init(variant: .bordered)
  }

  static func dsBorderedTextField(
    title: LocalizedStringResource? = nil,
    message: LocalizedStringResource? = nil,
    systemSymbol: DSSystemSymbol? = nil,
    accessory: DSTextFieldAccessory? = nil,
    state: DSTextFieldState = .normal,
    errorAnnouncement: LocalizedStringResource? = nil,
    cornerStyle: DSCornerStyle? = nil,
    appearance: DSTextFieldAppearance = .standard
  ) -> Self {
    .init(
      title: title,
      message: message,
      systemSymbol: systemSymbol,
      accessory: accessory,
      variant: .bordered,
      state: state,
      errorAnnouncement: errorAnnouncement,
      cornerStyle: cornerStyle,
      appearance: appearance
    )
  }
}
