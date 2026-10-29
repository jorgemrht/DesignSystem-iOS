import SwiftUI

public enum DSTextFieldAccessory {
  case clearButton(title: LocalizedStringResource, systemSymbol: DSSystemSymbol, isVisible: Bool, action: () -> Void)
  case systemImage(DSSystemSymbol)
  case button(title: LocalizedStringResource, systemSymbol: DSSystemSymbol, action: () -> Void)
  case text(LocalizedStringResource)

  public static func clear(
    _ text: Binding<String>,
    title: LocalizedStringResource,
    systemSymbol: DSSystemSymbol
  ) -> Self {
    .clearButton(title: title, systemSymbol: systemSymbol, isVisible: !text.wrappedValue.isEmpty) {
      text.wrappedValue = ""
    }
  }
}
