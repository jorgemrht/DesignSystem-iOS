import SwiftUI

public enum DSTextFieldVariant: Sendable, CaseIterable {
  case plain
  case tinted
  case bordered
  case underlined
}

public struct DSTextFieldStyle: @preconcurrency TextFieldStyle {
  private let title: LocalizedStringResource?
  private let message: LocalizedStringResource?
  private let systemSymbol: DSSystemSymbol?
  private let accessory: DSTextFieldAccessory?
  private let variant: DSTextFieldVariant
  private let state: DSTextFieldState
  private let errorAnnouncement: LocalizedStringResource?
  private let cornerStyle: DSCornerStyle?
  private let appearance: DSTextFieldAppearance

  init(
    title: LocalizedStringResource? = nil,
    message: LocalizedStringResource? = nil,
    systemSymbol: DSSystemSymbol? = nil,
    accessory: DSTextFieldAccessory? = nil,
    variant: DSTextFieldVariant = .plain,
    state: DSTextFieldState = .normal,
    errorAnnouncement: LocalizedStringResource? = nil,
    cornerStyle: DSCornerStyle? = nil,
    appearance: DSTextFieldAppearance = .standard
  ) {
    self.title = title
    self.message = message
    self.systemSymbol = systemSymbol
    self.accessory = accessory
    self.variant = variant
    self.state = state
    self.errorAnnouncement = errorAnnouncement
    self.cornerStyle = cornerStyle
    self.appearance = appearance
  }

  @MainActor public func _body(configuration: TextField<Self._Label>) -> some View {
    DSTextFieldStyleBody(
      configuration: configuration,
      title: title,
      message: message,
      systemSymbol: systemSymbol,
      accessory: accessory,
      variant: variant,
      state: state,
      errorAnnouncement: errorAnnouncement,
      cornerStyle: cornerStyle,
      appearance: appearance
    )
  }
}

private struct DSTextFieldStyleBody: View {
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.dsCornerStyle) private var inheritedCornerStyle
  @FocusState private var isFocused: Bool
  @ScaledMetric(relativeTo: .body) private var compactHeight: CGFloat = 44
  @ScaledMetric(relativeTo: .body) private var regularHeight: CGFloat = 52

  let configuration: TextField<DSTextFieldStyle._Label>
  let title: LocalizedStringResource?
  let message: LocalizedStringResource?
  let systemSymbol: DSSystemSymbol?
  let accessory: DSTextFieldAccessory?
  let variant: DSTextFieldVariant
  let state: DSTextFieldState
  let errorAnnouncement: LocalizedStringResource?
  let cornerStyle: DSCornerStyle?
  let appearance: DSTextFieldAppearance

  var body: some View {
    let resolvedState = resolvedState

    VStack(alignment: .leading, spacing: .spacingXXXS) {
      if let title {
        Text(title)
          .font(.subheadline)
          .foregroundStyle(appearance.labelColor(state: resolvedState, isEnabled: isEnabled))
          .accessibilityHidden(true)
      }

      HStack(spacing: .spacingXXS) {
        if let systemSymbol {
          Image(systemSymbol: systemSymbol)
            .foregroundStyle(appearance.promptColor(isEnabled: isEnabled))
            .accessibilityHidden(true)
        }

        field

        if let accessory {
          DSTextFieldAccessoryView(accessory: accessory, appearance: appearance)
        }
      }
      .padding(.horizontal, horizontalPadding)
      .frame(maxWidth: .infinity, minHeight: minHeight, alignment: .leading)
      .background {
        TextFieldBackground(
          variant: variant,
          state: resolvedState,
          appearance: appearance,
          cornerStyle: DSCornerStyle.resolved(
            cornerStyle,
            inherited: inheritedCornerStyle,
            default: .fixed(.cornerRadiusM)
          )
        )
      }

      TextFieldSupportText(
        message: message,
        errorAnnouncement: errorAnnouncement,
        state: resolvedState,
        appearance: appearance
      )
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  private var field: some View {
    let field = configuration
      .font(.body)
      .foregroundStyle(appearance.contentColor(isEnabled: isEnabled))
      .focused($isFocused)

    return Group {
      if let title {
        field.accessibilityLabel(Text(title))
      } else {
        field
      }
    }
  }

  private var horizontalPadding: CGFloat {
    switch variant {
    case .plain, .underlined:
      0
    case .tinted, .bordered:
      .spacingS
    }
  }

  private var minHeight: CGFloat {
    switch variant {
    case .plain, .underlined:
      compactHeight
    case .tinted, .bordered:
      regularHeight
    }
  }

  private var resolvedState: DSTextFieldState {
    state.resolved(isFocused: isFocused)
  }
}

private struct TextFieldBackground: View {
  @Environment(\.isEnabled) private var isEnabled

  let variant: DSTextFieldVariant
  let state: DSTextFieldState
  let appearance: DSTextFieldAppearance
  let cornerStyle: DSCornerStyle

  var body: some View {
    let outline = appearance.outlineColor(
      state: state,
      isEnabled: isEnabled,
      variant: variant
    )

    switch variant {
    case .plain:
      Color.clear

    case .tinted:
      DSCornerSurface(cornerStyle: cornerStyle, fill: appearance.containerColor(isEnabled: isEnabled))
        .overlay(alignment: .bottom) {
          Rectangle()
            .fill(outline)
            .frame(height: state.lineWidth)
        }

    case .bordered:
      DSCornerSurface(
        cornerStyle: cornerStyle,
        fill: appearance.outlinedContainer,
        outline: outline,
        lineWidth: state.lineWidth
      )

    case .underlined:
      Rectangle()
        .fill(outline)
        .frame(height: state.lineWidth)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
  }
}

#if DEBUG
private extension DSSystemSymbol {
  static let envelope = Self("envelope")
}

#Preview("Text input plain") {
  @Previewable @State var text = ""

  TextField("Email", text: $text)
    .textFieldStyle(.dsPlainTextField(title: "Email", message: "Help"))
    .padding(.spacingS)
    .background(.dsBackground)
}

#Preview("Text input tinted") {
  @Previewable @State var text = "dev@example.com"

  TextField("Email", text: $text)
    .textFieldStyle(.dsTintedTextField(title: "Tinted", systemSymbol: .envelope))
    .padding(.spacingS)
    .background(.dsBackground)
}

#Preview("Text input bordered error") {
  @Previewable @State var text = "dev@example.com"

  TextField("Email", text: $text)
    .textFieldStyle(.dsBorderedTextField(title: "Bordered", message: "Error", state: .error))
    .padding(.spacingS)
    .background(.dsBackground)
}

#Preview("Text input underlined disabled") {
  @Previewable @State var text = "dev@example.com"

  TextField("Email", text: $text)
    .textFieldStyle(.dsUnderlinedTextField(title: "Underlined"))
    .disabled(true)
    .padding(.spacingS)
    .background(.dsBackground)
}
#endif
