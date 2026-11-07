import JDesignSystem
import Observation
import SwiftUI

enum PreferencesField: Hashable, CaseIterable {
  case country
  case birthday
}

@Observable
@MainActor
final class PreferencesModel {
  static let countries = ["Spain", "Mexico", "Argentina"]
  static let plans = ["Free", "Pro", "Team"]

  var country = ""
  var birthday = Calendar.current.date(byAdding: .year, value: -10, to: .now) ?? .now
  var plan = "Free"
  var validation = DSFormValidation<PreferencesField>()

  let countryRule = DSValidation<String> { $0.isEmpty ? .invalid("Choose a country") : .valid }

  let birthdayRule = DSValidation<Date> { birthday in
    let years = Calendar.current.dateComponents([.year], from: birthday, to: .now).year ?? 0
    return years >= 18 ? .valid : .invalid("You must be at least 18")
  }

  func submit() {
    validation.validate(.country, country, using: countryRule)
    validation.validate(.birthday, birthday, using: birthdayRule)
  }
}

struct FormControlsShowcase: View {
  @State private var model = PreferencesModel()

  var body: some View {
    @Bindable var model = model

    Form {
      Section {
        LabeledContent("Country") {
          Picker("Country", selection: $model.country) {
            Text(verbatim: "Select").tag("")
            ForEach(PreferencesModel.countries, id: \.self) { country in
              Text(verbatim: country).tag(country)
            }
          }
          .labelsHidden()
          .showcaseMenuPicker()
        }
        .labeledContentStyle(.ds)
        .dsFieldMessage(model.validation[.country])
        .dsValidated(PreferencesField.country, value: model.country, validator: model.countryRule)

        #if !os(tvOS) && !os(watchOS)
        DatePicker(
          "Birthday",
          selection: $model.birthday,
          in: ...Date.now,
          displayedComponents: .date
        )
        .datePickerStyle(.ds)
        .dsFieldMessage(model.validation[.birthday])
        .dsValidated(PreferencesField.birthday, value: model.birthday, validator: model.birthdayRule)
        #endif
      } header: {
        Text(verbatim: "Pickers")
      } footer: {
        Text(verbatim: "Errors show after you change a value or tap Check")
      }

      #if os(iOS)
      Section {
        Picker("Plan", selection: $model.plan) {
          ForEach(PreferencesModel.plans, id: \.self) { plan in
            Text(verbatim: plan).tag(plan)
          }
        }
        .pickerStyle(.wheel)
        .frame(height: 120)
      } header: {
        Text(verbatim: "Wheel picker")
      }
      #endif

      Section {
        LabeledContent("Plan", value: model.plan)
          .labeledContentStyle(.ds)

        LabeledContent("Notifications", value: "On")
          .labeledContentStyle(.ds(disclosure: DSSystemSymbol("chevron.right")))
      } header: {
        Text(verbatim: "Rows")
      }

      Section {
        Button("Check", action: model.submit)
          .buttonStyle(.dsPrimary)
          .buttonSizing(.flexible)

        Button("Delete account", role: .destructive) {}
          .buttonStyle(.dsTertiary)
      }
    }
    .formStyle(.ds)
    .dsForm(validation: $model.validation)
  }
}

extension View {
  func showcaseMenuPicker() -> some View {
    #if os(watchOS) || os(tvOS)
    pickerStyle(.automatic)
    #else
    pickerStyle(.menu)
    #endif
  }
}
