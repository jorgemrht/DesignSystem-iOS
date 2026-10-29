@testable import JDesignSystem
import SwiftUI
import Testing

struct CornerStyleTests {
  @Test func `no corner style is inherited by default`() {
    #expect(EnvironmentValues().dsCornerStyle == nil)
  }

  @Test(arguments: [
    DSCornerStyle.capsule,
    DSCornerStyle.fixed(8),
    DSCornerStyle.concentric(minimum: 4)
  ])
  func `the environment stores the style it is given`(style: DSCornerStyle) {
    var environment = EnvironmentValues()
    environment.dsCornerStyle = style
    #expect(environment.dsCornerStyle == style)
  }

  @Test(arguments: [
    (DSCornerStyle?.none, DSCornerStyle?.none, DSCornerStyle.capsule, DSCornerStyle.capsule),
    (DSCornerStyle?.none, DSCornerStyle?.some(.fixed(8)), DSCornerStyle.capsule, DSCornerStyle.fixed(8)),
    (DSCornerStyle?.some(.fixed(4)), DSCornerStyle?.none, DSCornerStyle.capsule, DSCornerStyle.fixed(4)),
    (DSCornerStyle?.some(.fixed(4)), DSCornerStyle?.some(.fixed(8)), DSCornerStyle.capsule, DSCornerStyle.fixed(4)),
    (
      DSCornerStyle?.some(.capsule),
      DSCornerStyle?.some(.concentric(minimum: 4)),
      DSCornerStyle.fixed(12),
      DSCornerStyle.capsule
    )
  ])
  func `explicit wins over inherited and inherited wins over the default`(
    explicit: DSCornerStyle?,
    inherited: DSCornerStyle?,
    fallback: DSCornerStyle,
    expected: DSCornerStyle
  ) {
    #expect(DSCornerStyle.resolved(explicit, inherited: inherited, default: fallback) == expected)
  }
}
