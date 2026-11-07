import SwiftUI

public extension View {
  func dsFieldMessage(_ result: DSValidationResult?, appearance: DSTextFieldAppearance = .standard) -> some View {
    VStack(alignment: .leading, spacing: .spacingXXXS) {
      self

      TextFieldSupportText(
        message: result?.message,
        errorAnnouncement: result?.message,
        state: DSTextFieldState(result),
        appearance: appearance
      )
    }
  }
}
