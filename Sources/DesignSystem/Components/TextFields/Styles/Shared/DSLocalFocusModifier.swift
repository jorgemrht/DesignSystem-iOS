import SwiftUI

struct DSLocalFocusModifier: ViewModifier {
  let context: DSFieldContext?
  let binding: FocusState<Bool>.Binding

  func body(content: Content) -> some View {
    if context?.ownsFocus == true {
      content
    } else {
      content.focused(binding)
    }
  }
}
