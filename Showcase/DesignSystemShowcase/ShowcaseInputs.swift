import JDesignSystem
import SwiftUI

struct TextFieldsShowcase: View {
  @State private var plain = ""
  @State private var tinted = "example@example.com"
  @State private var bordered = ""
  @State private var underlined = ""

  var body: some View {
    ShowcasePage {
      ShowcaseGroup(title: "Plain") {
        TextField("Name", text: $plain)
          .textFieldStyle(.dsPlainTextField(title: "Name", message: "Helper text"))
      }

      ShowcaseGroup(title: "Tinted · icon and clear button") {
        TextField("Email", text: $tinted)
          .textFieldStyle(
            .dsTintedTextField(
              title: "Email",
              systemSymbol: .envelope,
              accessory: .clear(
                $tinted,
                title: "Clear",
                systemSymbol: .clearText
              )
            )
          )
      }

      ShowcaseGroup(title: "Bordered · error") {
        TextField("Password", text: $bordered)
          .textFieldStyle(
            .dsBorderedTextField(
              title: "Password",
              message: "At least 8 characters",
              state: .error
            )
          )
      }

      ShowcaseGroup(title: "Underlined · disabled") {
        TextField("Username", text: $underlined)
          .textFieldStyle(.dsUnderlinedTextField(title: "Username"))
          .disabled(true)
      }
    }
  }
}

struct TextAreaShowcase: View {
  @State private var notes = ""
  @State private var invalid = ""

  var body: some View {
    ShowcasePage {
      #if os(tvOS) || os(watchOS)
      Text(verbatim: "TextEditor is not available on this platform")
      #else
      DSTextArea(
        "Notes",
        text: $notes,
        placeholder: "Write here",
        message: "Maximum 120 characters",
        maxLength: 120,
        showsCharacterCount: true
      )

      DSTextArea("Comment", text: $invalid, message: "Required field", state: .error)
      #endif
    }
  }
}

struct TogglesShowcase: View {
  @State private var notifications = true
  @State private var airplane = false
  @State private var terms = true
  @State private var newsletter = false

  var body: some View {
    ShowcasePage {
      ShowcaseGroup(title: "Switch") {
        Toggle(isOn: $notifications) { Text(verbatim: "Notifications") }
          .toggleStyle(.dsSwitch)
        Toggle(isOn: $airplane) { Text(verbatim: "Airplane mode") }
          .toggleStyle(.dsSwitch)
      }

      ShowcaseGroup(title: "Switch · disabled") {
        Toggle(isOn: .constant(true)) { Text(verbatim: "On") }
          .toggleStyle(.dsSwitch)
          .disabled(true)
        Toggle(isOn: .constant(false)) { Text(verbatim: "Off") }
          .toggleStyle(.dsSwitch)
          .disabled(true)
      }

      ShowcaseGroup(title: "Checkbox") {
        Toggle(isOn: $terms) { Text(verbatim: "Accept the terms") }
          .toggleStyle(.dsCheckbox)
        Toggle(isOn: $newsletter) { Text(verbatim: "Subscribe to the newsletter") }
          .toggleStyle(.dsCheckbox)
      }

      ShowcaseGroup(title: "Checkbox · disabled") {
        Toggle(isOn: .constant(true)) { Text(verbatim: "On") }
          .toggleStyle(.dsCheckbox)
          .disabled(true)
        Toggle(isOn: .constant(false)) { Text(verbatim: "Off") }
          .toggleStyle(.dsCheckbox)
          .disabled(true)
      }
    }
  }
}
