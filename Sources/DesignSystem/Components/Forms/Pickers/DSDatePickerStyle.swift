import SwiftUI

#if !os(tvOS) && !os(watchOS)

public struct DSDatePickerStyle: DatePickerStyle {
  public init() {}

  public func makeBody(configuration: Configuration) -> some View {
    DSFormRow {
      configuration.label
        .accessibilityHidden(true)
    } trailing: {
      DatePicker(
        selection: configuration.$selection,
        in: (configuration.minimumDate ?? .distantPast) ... (configuration.maximumDate ?? .distantFuture),
        displayedComponents: configuration.displayedComponents
      ) {
        configuration.label
      }
      .labelsHidden()
      .datePickerStyle(.compact)
    }
  }
}

public extension DatePickerStyle where Self == DSDatePickerStyle {
  static var ds: DSDatePickerStyle {
    DSDatePickerStyle()
  }
}

#endif
