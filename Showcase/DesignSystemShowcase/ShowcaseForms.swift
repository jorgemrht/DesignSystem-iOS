import JDesignSystem
import Observation
import SwiftUI

enum SignUpField: Hashable, CaseIterable {
  case name
  case email
  case password
}

@Observable
@MainActor
final class SignUpModel {
  var name = ""
  var email = ""
  var password = ""
  var validation = DSFormValidation<SignUpField>()
  var isSubmitted = false

  let nameRule = DSValidation<String> { name in
    name.trimmingCharacters(in: .whitespaces).isEmpty ? .invalid("Enter your name") : .valid
  }

  let emailRule = DSValidation<String>.all([
    DSValidation<String> { $0.isEmpty ? .invalid("Enter your email") : .valid },
    DSValidation<String> { $0.contains("@") && $0.contains(".") ? .valid : .invalid("This is not a valid email") }
  ])

  let passwordRule = DSValidation<String> { password in
    password.count >= 8 ? .valid : .invalid("Use at least 8 characters")
  }

  func submit() -> SignUpField? {
    validation.validate(.name, name, using: nameRule)
    validation.validate(.email, email, using: emailRule)
    validation.validate(.password, password, using: passwordRule)
    isSubmitted = !validation.hasErrors
    return validation.firstInvalid
  }
}

struct FormsShowcase: View {
  @State private var model = SignUpModel()
  @FocusState private var focus: SignUpField?

  var body: some View {
    @Bindable var model = model

    Form {
      Section {
        TextField("Name", text: $model.name)
          .textFieldStyle(.dsBorderedTextField(title: "Name"))
          .dsField(SignUpField.name, value: model.name, validator: model.nameRule)

        TextField("Email", text: $model.email)
          .textFieldStyle(.dsBorderedTextField(title: "Email"))
          .dsField(SignUpField.email, value: model.email, validator: model.emailRule)

        SecureField("Password", text: $model.password)
          .textFieldStyle(.dsBorderedTextField(title: "Password"))
          .dsField(
            SignUpField.password,
            value: model.password,
            validator: model.passwordRule,
            onSubmit: submit
          )
      } header: {
        Text(verbatim: "Create account")
      } footer: {
        Text(verbatim: model.isSubmitted ? "Account created" : "Return moves to the next field")
      }

      Section {
        Button("Sign up", action: submit)
          .buttonStyle(.dsPrimary)
          .buttonSizing(.flexible)
      }
    }
    .formStyle(.ds)
    .dsForm(
      validation: $model.validation,
      focus: $focus,
      keyboardToolbar: DSFormKeyboardToolbar(previous: "Previous", next: "Next", done: "Done")
    )
  }

  private func submit() {
    focus = model.submit()
  }
}
