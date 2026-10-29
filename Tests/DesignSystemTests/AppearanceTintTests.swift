@testable import JDesignSystem
import SwiftUI
import Testing

struct AppearanceTintTests {
  nonisolated private static let tints: [Color] = [.dsTertiary, .dsPrimaryContainer, .dsError]

  @Test(arguments: tints)
  func `a tinted toggle uses the color for its on track`(tint: Color) {
    #expect(rgba(DSToggleAppearance.tinted(tint).onTrack) == rgba(tint))
  }

  @Test(arguments: tints)
  func `a tinted progress uses the color for its indicator`(tint: Color) {
    #expect(rgba(DSProgressAppearance.tinted(tint).indicator) == rgba(tint))
  }

  @Test(arguments: tints)
  func `a tinted card uses the color for its filled container`(tint: Color) {
    #expect(rgba(DSCardAppearance.tinted(tint).filledContainer) == rgba(tint))
  }

  @Test(arguments: tints)
  func `a tinted text field uses the color for its focus indicator`(tint: Color) {
    #expect(rgba(DSTextFieldAppearance.tinted(tint).focusedIndicator) == rgba(tint))
  }

  @Test(arguments: tints)
  func `a tinted skeleton keeps its color`(tint: Color) {
    #expect(DSSkeletonAppearance.tinted(tint).tint.map { rgba($0) } == rgba(tint))
  }

  @Test func `the standard appearances keep the original colors`() {
    #expect(rgba(DSToggleAppearance.standard.onTrack) == rgba(.dsPrimary))
    #expect(rgba(DSProgressAppearance.standard.indicator) == rgba(.dsPrimary))
    #expect(rgba(DSCardAppearance.standard.filledContainer) == rgba(.dsSurfaceVariant))
    #expect(rgba(DSTextFieldAppearance.standard.focusedIndicator) == rgba(.dsPrimary))
    #expect(DSSkeletonAppearance.standard.tint == nil)
  }
}
