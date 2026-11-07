import SwiftUI

public struct DSFormKeyboardToolbar: Sendable {
  let previous: LocalizedStringResource
  let next: LocalizedStringResource
  let done: LocalizedStringResource

  public init(previous: LocalizedStringResource, next: LocalizedStringResource, done: LocalizedStringResource) {
    self.previous = previous
    self.next = next
    self.done = done
  }
}

struct DSResolvedForm<Field: Hashable & CaseIterable> {
  let focus: FocusState<Field?>.Binding?
  let validation: Binding<DSFormValidation<Field>>
  let order: [Field]
}

struct DSFormContext {
  private let form: Any

  init(_ form: DSResolvedForm<some Hashable & CaseIterable>) {
    self.form = form
  }

  func resolved<Field: Hashable & CaseIterable>(for _: Field.Type) -> DSResolvedForm<Field>? {
    form as? DSResolvedForm<Field>
  }
}

extension EnvironmentValues {
  @Entry var dsFormContext: DSFormContext?
}

public extension View {
  func dsForm<Field: Hashable & CaseIterable>(
    validation: Binding<DSFormValidation<Field>>,
    focus: FocusState<Field?>.Binding,
    order: [Field] = Array(Field.allCases),
    keyboardToolbar: DSFormKeyboardToolbar? = nil
  ) -> some View {
    dsFormContext(DSResolvedForm(focus: focus, validation: validation, order: order))
      .modifier(DSKeyboardToolbarModifier(focus: focus, order: order, toolbar: keyboardToolbar))
  }

  func dsForm(
    validation: Binding<DSFormValidation<some Hashable & CaseIterable>>
  ) -> some View {
    dsFormContext(DSResolvedForm(focus: nil, validation: validation, order: []))
  }
}

private extension View {
  func dsFormContext(_ form: DSResolvedForm<some Hashable & CaseIterable>) -> some View {
    environment(\.dsFormContext, DSFormContext(form))
  }
}

#if os(iOS)
private struct DSKeyboardToolbarButtons<Field: Hashable & CaseIterable>: View {
  let focus: FocusState<Field?>.Binding
  let order: [Field]
  let toolbar: DSFormKeyboardToolbar

  var body: some View {
    let previous = focus.wrappedValue.flatMap { order.element(before: $0) }
    let next = focus.wrappedValue.flatMap { order.element(after: $0) }

    Button(toolbar.previous) {
      focus.wrappedValue = previous
    }
    .disabled(previous == nil)

    Button(toolbar.next) {
      focus.wrappedValue = next
    }
    .disabled(next == nil)

    Spacer()

    Button(toolbar.done) {
      focus.wrappedValue = nil
    }
  }
}
#endif

private struct DSKeyboardToolbarModifier<Field: Hashable & CaseIterable>: ViewModifier {
  let focus: FocusState<Field?>.Binding
  let order: [Field]
  let toolbar: DSFormKeyboardToolbar?

  @ViewBuilder
  func body(content: Content) -> some View {
    #if os(iOS)
    if let toolbar {
      content.toolbar {
        ToolbarItemGroup(placement: .keyboard) {
          DSKeyboardToolbarButtons(focus: focus, order: order, toolbar: toolbar)
        }
      }
    } else {
      content
    }
    #else
    content
    #endif
  }
}
