import os
import SwiftUI

public extension View {
  func dsField<Validator: DSValidator>(
    _ field: some Hashable & CaseIterable,
    value: Validator.Value,
    validator: Validator,
    onSubmit: @escaping () -> Void = {}
  ) -> some View where Validator.Value: Equatable {
    dsResolvedFocus(field) { content, form, focus in
      content.modifier(
        DSFieldModifier(
          field: field,
          value: value,
          validator: validator,
          form: form,
          focus: focus,
          onSubmit: onSubmit
        )
      )
    }
  }

  func dsField(
    _ field: some Hashable & CaseIterable,
    onSubmit: @escaping () -> Void = {}
  ) -> some View {
    dsResolvedFocus(field) { content, form, focus in
      content.modifier(DSFocusModifier(field: field, order: form.order, focus: focus, onSubmit: onSubmit))
    }
  }

  func dsValidated<Validator: DSValidator>(
    _ field: some Hashable & CaseIterable,
    value: Validator.Value,
    validator: Validator
  ) -> some View where Validator.Value: Equatable {
    dsResolved(field) { content, form in
      content
        .onChange(of: value) {
          form.validation.wrappedValue.validate(field, value, using: validator)
        }
        .dsFieldContext(result: form.validation.wrappedValue[field], focus: .local)
    }
  }
}

private extension View {
  func dsResolved<Field: Hashable & CaseIterable>(
    _: Field,
    @ViewBuilder build: @escaping (Self, DSResolvedForm<Field>) -> some View
  ) -> some View {
    DSFormResolver(source: self, build: build)
  }

  func dsResolvedFocus<Field: Hashable & CaseIterable>(
    _ field: Field,
    @ViewBuilder build: @escaping (Self, DSResolvedForm<Field>, FocusState<Field?>.Binding) -> some View
  ) -> some View {
    dsResolved(field) { content, form in
      if let focus = form.focus {
        build(content, form, focus)
      } else {
        content.dsAssertion("A focus field of type \(Field.self) needs a dsForm that has a focus binding")
      }
    }
  }

  func dsAssertion(_ message: String) -> some View {
    onAppear {
      #if DEBUG
      assertionFailure(message)
      #else
      Logger(subsystem: "JDesignSystem", category: "Forms").fault("\(message, privacy: .public)")
      #endif
    }
  }
}

private struct DSFormResolver<Field: Hashable & CaseIterable, Source: View, Result: View>: View {
  @Environment(\.dsFormContext) private var context

  let source: Source
  let build: (Source, DSResolvedForm<Field>) -> Result

  var body: some View {
    if let form = context?.resolved(for: Field.self) {
      build(source, form)
    } else {
      source.dsAssertion("A field of type \(Field.self) has no matching dsForm above it")
    }
  }
}

private struct DSFocusModifier<Field: Hashable & CaseIterable>: ViewModifier {
  let field: Field
  let order: [Field]
  let focus: FocusState<Field?>.Binding
  var result: DSValidationResult?
  var beforeAdvance: () -> Bool = { true }
  let onSubmit: () -> Void

  private var next: Field? {
    order.element(after: field)
  }

  func body(content: Content) -> some View {
    content
      .focused(focus, equals: field)
      .submitLabel(next == nil ? .done : .next)
      .onSubmit(submit)
      .dsFieldContext(result: result, focus: .external(isFocused: focus.wrappedValue == field))
  }

  private func submit() {
    guard beforeAdvance() else {
      return
    }
    if let next {
      focus.wrappedValue = next
    } else {
      onSubmit()
    }
  }
}

private struct DSFieldModifier<Field: Hashable & CaseIterable, Validator: DSValidator>: ViewModifier
  where Validator.Value: Equatable {
  let field: Field
  let value: Validator.Value
  let validator: Validator
  let form: DSResolvedForm<Field>
  let focus: FocusState<Field?>.Binding
  let onSubmit: () -> Void

  func body(content: Content) -> some View {
    content
      .modifier(
        DSFocusModifier(
          field: field,
          order: form.order,
          focus: focus,
          result: form.validation.wrappedValue[field],
          beforeAdvance: { validate().isValid },
          onSubmit: onSubmit
        )
      )
      .onChange(of: value) {
        if form.validation.wrappedValue[field] != nil {
          validate()
        }
      }
      .onChange(of: focus.wrappedValue) { previous, _ in
        if previous == field {
          validate()
        }
      }
  }

  @discardableResult
  private func validate() -> DSValidationResult {
    form.validation.wrappedValue.validate(field, value, using: validator)
  }
}
