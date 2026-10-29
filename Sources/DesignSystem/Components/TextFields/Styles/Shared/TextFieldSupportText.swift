import SwiftUI

struct TextFieldSupportText: View {
  let message: LocalizedStringResource?
  let errorAnnouncement: LocalizedStringResource?
  let state: DSTextFieldState
  let appearance: DSTextFieldAppearance

  @Environment(\.isEnabled) private var isEnabled

  var body: some View {
    if let message {
      Text(message)
        .font(.caption)
        .foregroundStyle(appearance.supportColor(state: state, isEnabled: isEnabled))
        .accessibilityValue(announcement)
    }
  }

  private var announcement: Text {
    guard state == .error, let errorAnnouncement else {
      return Text(verbatim: "")
    }
    return Text(errorAnnouncement)
  }
}
