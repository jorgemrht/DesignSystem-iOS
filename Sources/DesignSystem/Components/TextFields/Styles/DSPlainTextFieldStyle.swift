import SwiftUI

public extension TextFieldStyle where Self == DSTextFieldStyle {
  static var dsPlainTextField: Self {
    .init(variant: .plain)
  }

  static func dsPlainTextField(
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
      variant: .plain,
      state: state,
      errorAnnouncement: errorAnnouncement,
      cornerStyle: cornerStyle,
      appearance: appearance
    )
  }
}
