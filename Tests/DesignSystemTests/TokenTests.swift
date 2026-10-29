import JDesignSystem
import SwiftUI
import Testing

struct TokenTests {
  @Test func `spacing tokens follow the documented scale`() {
    let spacing: [CGFloat] = [
      .spacingXXXXS, .spacingXXXS, .spacingXXS, .spacingXS, .spacingS,
      .spacingM, .spacingL, .spacingXL, .spacingXXL
    ]
    #expect(spacing == [2, 4, 8, 12, 16, 24, 32, 40, 48])
  }

  @Test func `corner radius tokens grow monotonically from zero`() {
    let radii: [CGFloat] = [
      .cornerRadiusNone, .cornerRadiusXS, .cornerRadiusS, .cornerRadiusM,
      .cornerRadiusL, .cornerRadiusXL, .cornerRadiusXXL
    ]
    #expect(radii == [0, 4, 8, 12, 16, 24, 32])
    #expect(radii == radii.sorted())
  }

  @Test func `control sizes keep the minimum touch target`() {
    let controls: [CGFloat] = [.controlSizeS, .controlSizeM, .controlSizeL, .controlSizeXL]
    #expect(controls == [44, 48, 56, 68])
    #expect(controls.allSatisfy { $0 >= 44 })
    #expect(CGFloat.iconSizeM < .iconSizeL)
  }

  @Test(arguments: [
    (Double.opacityDisabled, 0.38),
    (Double.opacityDisabledSubtle, 0.12),
    (Double.opacityDisabledOutline, 0.24),
    (Double.opacityDisabledFill, 0.04),
    (Double.opacityPressedContent, 0.70),
    (Double.opacityPressedOverlay, 0.10)
  ])
  func `opacity tokens keep their state values`(token: Double, expected: Double) {
    #expect(token == expected)
  }
}
