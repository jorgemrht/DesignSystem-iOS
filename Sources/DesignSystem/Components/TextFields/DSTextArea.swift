import SwiftUI

#if !os(tvOS) && !os(watchOS)

public struct DSTextArea: View {
  private let title: LocalizedStringResource?
  private let placeholder: LocalizedStringResource
  private let message: LocalizedStringResource?
  private let state: DSTextFieldState
  private let errorAnnouncement: LocalizedStringResource?
  private let minHeight: CGFloat
  private let maxLength: Int?
  private let showsCharacterCount: Bool
  private let cornerStyle: DSCornerStyle?
  private let appearance: DSTextFieldAppearance

  @Binding private var text: String
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.dsCornerStyle) private var inheritedCornerStyle
  @FocusState private var isFocused: Bool

  public init(
    _ title: LocalizedStringResource? = nil,
    text: Binding<String>,
    placeholder: LocalizedStringResource = "",
    message: LocalizedStringResource? = nil,
    state: DSTextFieldState = .normal,
    errorAnnouncement: LocalizedStringResource? = nil,
    minHeight: CGFloat = 120,
    maxLength: Int? = nil,
    showsCharacterCount: Bool = false,
    cornerStyle: DSCornerStyle? = nil,
    appearance: DSTextFieldAppearance = .standard
  ) {
    self.title = title
    _text = text
    self.placeholder = placeholder
    self.message = message
    self.state = state
    self.errorAnnouncement = errorAnnouncement
    self.minHeight = minHeight
    self.maxLength = maxLength
    self.showsCharacterCount = showsCharacterCount
    self.cornerStyle = cornerStyle
    self.appearance = appearance
  }

  public var body: some View {
    let resolvedState = resolvedState

    VStack(alignment: .leading, spacing: .spacingXXXS) {
      if let title {
        Text(title)
          .font(.subheadline)
          .foregroundStyle(appearance.labelColor(state: resolvedState, isEnabled: isEnabled))
          .accessibilityHidden(true)
      }

      ZStack(alignment: .topLeading) {
        if text.isEmpty {
          Text(placeholder)
            .font(.body)
            .foregroundStyle(appearance.promptColor(isEnabled: isEnabled))
            .padding(.top, .spacingXS)
            .padding(.horizontal, .spacingS)
            .allowsHitTesting(false)
            .accessibilityHidden(true)
        }

        TextEditor(text: $text)
          .font(.body)
          .foregroundStyle(appearance.contentColor(isEnabled: isEnabled))
          .scrollContentBackground(.hidden)
          .padding(.horizontal, .spacingXXS)
          .padding(.vertical, .spacingXXXS)
          .frame(minHeight: minHeight)
          .focused($isFocused)
          .accessibilityLabel(Text(title ?? placeholder))
          .onChange(of: text) { _, newValue in
            let limited = Self.limited(newValue, to: maxLength)
            if limited != newValue {
              text = limited
            }
          }
      }
      .background {
        DSCornerSurface(
          cornerStyle: DSCornerStyle.resolved(
            cornerStyle,
            inherited: inheritedCornerStyle,
            default: .fixed(.cornerRadiusM)
          ),
          fill: appearance.outlinedContainer,
          outline: appearance.outlineColor(state: resolvedState, isEnabled: isEnabled, variant: .bordered),
          lineWidth: resolvedState.lineWidth
        )
      }

      HStack(alignment: .firstTextBaseline, spacing: .spacingXXS) {
        TextFieldSupportText(
          message: message,
          errorAnnouncement: errorAnnouncement,
          state: resolvedState,
          appearance: appearance
        )

        Spacer(minLength: .spacingXXS)

        if showsCharacterCount, let maxLength {
          Text(verbatim: "\(text.count)/\(maxLength)")
            .font(.caption)
            .foregroundStyle(appearance.supportColor(state: resolvedState, isEnabled: isEnabled))
        }
      }
    }
  }

  static func limited(_ text: String, to maxLength: Int?) -> String {
    guard let maxLength, text.count > maxLength else { return text }
    return String(text.prefix(maxLength))
  }

  private var resolvedState: DSTextFieldState {
    state.resolved(isFocused: isFocused)
  }
}

#if DEBUG
#Preview("Text area counter") {
  @Previewable @State var text = ""

  DSTextArea("Notes", text: $text, placeholder: "Write here", maxLength: 120, showsCharacterCount: true)
    .padding(.spacingS)
    .background(.dsBackground)
}

#Preview("Text area error") {
  @Previewable @State var text = ""

  DSTextArea("Error", text: $text, message: "Required field", state: .error)
    .padding(.spacingS)
    .background(.dsBackground)
}
#endif
#endif
