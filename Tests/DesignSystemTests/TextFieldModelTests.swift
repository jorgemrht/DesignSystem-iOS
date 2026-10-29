@testable import JDesignSystem
import SwiftUI
import Testing

struct TextFieldModelTests {
  private let standard = DSTextFieldAppearance.standard

  @Test func `states and variants list every case`() {
    #expect(DSTextFieldState.allCases == [.normal, .focused, .error])
    #expect(DSTextFieldVariant.allCases == [.plain, .tinted, .bordered, .underlined])
  }

  @Test func `label and support colors switch to error and fade when disabled`() {
    #expect(rgba(standard.labelColor(state: .normal, isEnabled: true)) == rgba(.dsOnSurfaceVariant))
    #expect(rgba(standard.labelColor(state: .error, isEnabled: true)) == rgba(.dsError))
    #expect(rgba(standard.supportColor(state: .error, isEnabled: true)) == rgba(.dsError))
    #expect(rgba(standard.supportColor(state: .focused, isEnabled: true)) == rgba(.dsOnSurfaceVariant))
    #expect(rgba(standard.labelColor(state: .error, isEnabled: false)) == rgba(standard.disabledContent))
    #expect(rgba(standard.supportColor(state: .normal, isEnabled: false)) == rgba(standard.disabledContent))
  }

  @Test func `content prompt and container colors depend on enabled`() {
    #expect(rgba(standard.contentColor(isEnabled: true)) == rgba(.dsOnSurface))
    #expect(rgba(standard.promptColor(isEnabled: true)) == rgba(.dsOnSurfaceVariant))
    #expect(rgba(standard.containerColor(isEnabled: true)) == rgba(.dsSurfaceVariant))
    #expect(rgba(standard.contentColor(isEnabled: false)) == rgba(standard.disabledContent))
    #expect(rgba(standard.promptColor(isEnabled: false)) == rgba(standard.disabledContent))
    #expect(rgba(standard.containerColor(isEnabled: false)) == rgba(standard.disabledContainer))
  }

  @Test(arguments: DSTextFieldVariant.allCases)
  func `outline follows the state while enabled`(variant: DSTextFieldVariant) {
    #expect(
      rgba(standard.outlineColor(state: .normal, isEnabled: true, variant: variant))
        == rgba(.dsOutline)
    )
    #expect(
      rgba(standard.outlineColor(state: .focused, isEnabled: true, variant: variant))
        == rgba(.dsPrimary)
    )
    #expect(
      rgba(standard.outlineColor(state: .error, isEnabled: true, variant: variant))
        == rgba(.dsError)
    )
  }

  @Test func `disabled outline depends on the variant`() {
    func disabled(_ variant: DSTextFieldVariant) -> [Float] {
      rgba(standard.outlineColor(state: .normal, isEnabled: false, variant: variant))
    }
    #expect(disabled(.plain) == rgba(.clear))
    #expect(disabled(.tinted) == rgba(standard.disabledFilledIndicator))
    #expect(disabled(.underlined) == rgba(standard.disabledFilledIndicator))
    #expect(disabled(.bordered) == rgba(standard.disabledOutlinedIndicator))
  }

  @Test func `custom appearance replaces the standard colors`() {
    let custom = DSTextFieldAppearance(
      text: .red,
      prompt: .green,
      label: .blue,
      helper: .orange,
      container: .yellow,
      indicator: .purple,
      focusedIndicator: .pink,
      error: .brown
    )
    #expect(rgba(custom.contentColor(isEnabled: true)) == rgba(.red))
    #expect(rgba(custom.labelColor(state: .normal, isEnabled: true)) == rgba(.blue))
    #expect(rgba(custom.supportColor(state: .normal, isEnabled: true)) == rgba(.orange))
    #expect(rgba(custom.outlineColor(state: .focused, isEnabled: true, variant: .bordered)) == rgba(.pink))
    #expect(rgba(custom.outlinedContainer) == rgba(.dsSurface))
  }

  @Test func `clear accessory is visible only with text and empties the binding`() {
    final class Box { var value = "" }
    let box = Box()
    let binding = Binding(get: { box.value }, set: { box.value = $0 })

    box.value = ""
    guard case let .clearButton(_, _, emptyVisible, _) = DSTextFieldAccessory.clear(
      binding, title: "Clear", systemSymbol: .testClose
    ) else {
      Issue.record("clear must build a clearButton accessory")
      return
    }
    #expect(emptyVisible == false)

    box.value = "text"
    guard case let .clearButton(title, symbol, isVisible, action) = DSTextFieldAccessory.clear(
      binding, title: "Clear", systemSymbol: .testClose
    ) else {
      Issue.record("clear must build a clearButton accessory")
      return
    }
    #expect(isVisible)
    #expect(symbol == .testClose)
    _ = title
    action()
    #expect(box.value.isEmpty)
  }

  #if !os(tvOS) && !os(watchOS)
  @Test func `text area limits the text to the maximum length`() {
    #expect(DSTextArea.limited("abcdef", to: 3) == "abc")
    #expect(DSTextArea.limited("abc", to: 3) == "abc")
    #expect(DSTextArea.limited("ab", to: 3) == "ab")
    #expect(DSTextArea.limited("abcdef", to: nil) == "abcdef")
    #expect(DSTextArea.limited("", to: 0).isEmpty)
    #expect(DSTextArea.limited("👍🏽👍🏽👍🏽", to: 2) == "👍🏽👍🏽")
  }
  #endif
}
