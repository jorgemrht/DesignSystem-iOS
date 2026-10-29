import SwiftUI

public extension TextFieldStyle where Self == DSTextFieldStyle {
  static var dsUnderlinedTextField: Self {
    .init(variant: .underlined)
  }

  static func dsUnderlinedTextField(
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
      variant: .underlined,
      state: state,
      errorAnnouncement: errorAnnouncement,
      cornerStyle: cornerStyle,
      appearance: appearance
    )
  }
}
