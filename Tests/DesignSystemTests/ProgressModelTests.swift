@testable import JDesignSystem
import SwiftUI
import Testing

struct ProgressModelTests {
  @Test func `variants list every case`() {
    #expect(DSProgressVariant.allCases == [.circular, .linear])
  }

  @Test(arguments: [
    (-0.5, 0.0),
    (0.0, 0.0),
    (0.25, 0.25),
    (1.0, 1.0),
    (1.7, 1.0),
    (Double.nan, 0.0),
    (Double.infinity, 1.0),
    (-Double.infinity, 0.0)
  ])
  func `fractions stay between zero and one`(fraction: Double, expected: Double) {
    #expect(DSProgressMetrics.clamped(fraction) == expected)
  }

  @Test(arguments: [
    (CGFloat(1), CGFloat(40), CGFloat(4)),
    (CGFloat(2), CGFloat(80), CGFloat(8)),
    (CGFloat(3), CGFloat(120), CGFloat(12))
  ])
  func `the indicator scales with dynamic type`(scale: CGFloat, diameter: CGFloat, lineWidth: CGFloat) {
    let metrics = DSProgressMetrics(scale: scale)
    #expect(metrics.circularDiameter == diameter)
    #expect(metrics.lineWidth == lineWidth)
  }

  @Test(arguments: [
    (ControlSize.mini, CGFloat(16)),
    (ControlSize.small, CGFloat(24)),
    (ControlSize.regular, CGFloat(40)),
    (ControlSize.large, CGFloat(56)),
    (ControlSize.extraLarge, CGFloat(72))
  ])
  func `the ring follows the control size`(controlSize: ControlSize, diameter: CGFloat) {
    #expect(DSProgressMetrics(scale: 1, controlSize: controlSize).circularDiameter == diameter)
  }

  @Test func `standard appearance uses the primary indicator on a secondary container track`() {
    let standard = DSProgressAppearance.standard
    #expect(rgba(standard.indicator) == rgba(.dsPrimary))
    #expect(rgba(standard.track) == rgba(.dsSecondaryContainer))
    #expect(rgba(standard.label) == rgba(.dsOnSurface))
    #expect(rgba(standard.value) == rgba(.dsOnSurfaceVariant))
  }
}
