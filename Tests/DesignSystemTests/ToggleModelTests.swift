@testable import JDesignSystem
import SwiftUI
import Testing

struct ToggleStateCase: Sendable {
  let isOn: Bool
  let isEnabled: Bool
  let track: Color
  let thumb: Color
  let outline: Color
}

struct SwitchThumbCase: Sendable {
  let isOn: Bool
  let isPressed: Bool
  let diameter: CGFloat
  let inset: CGFloat
}

struct ToggleModelTests {
  private let standard = DSToggleAppearance.standard

  @Test func `variants list every case`() {
    #expect(DSToggleVariant.allCases == [.switch, .checkbox])
  }

  @Test(arguments: [
    ToggleStateCase(
      isOn: true,
      isEnabled: true,
      track: .dsPrimary,
      thumb: .dsOnPrimary,
      outline: .clear
    ),
    ToggleStateCase(
      isOn: false,
      isEnabled: true,
      track: .dsSurfaceVariant,
      thumb: .dsOutline,
      outline: .dsOutline
    ),
    ToggleStateCase(
      isOn: true,
      isEnabled: false,
      track: .dsOnSurface.opacity(0.38),
      thumb: .dsSurface,
      outline: .clear
    ),
    ToggleStateCase(
      isOn: false,
      isEnabled: false,
      track: .dsSurfaceVariant.opacity(0.12),
      thumb: .dsOnSurface.opacity(0.38),
      outline: .dsOnSurface.opacity(0.12)
    )
  ])
  func `standard appearance resolves the colors of every state`(scenario: ToggleStateCase) {
    #expect(
      rgba(standard.trackColor(isOn: scenario.isOn, isEnabled: scenario.isEnabled)) == rgba(scenario.track)
    )
    #expect(
      rgba(standard.thumbColor(isOn: scenario.isOn, isEnabled: scenario.isEnabled)) == rgba(scenario.thumb)
    )
    #expect(
      rgba(standard.outlineColor(isOn: scenario.isOn, isEnabled: scenario.isEnabled)) == rgba(scenario.outline)
    )
  }

  @Test(arguments: [
    (true, Color.dsOnSurface),
    (false, Color.dsOnSurface.opacity(0.38))
  ])
  func `label fades when disabled`(isEnabled: Bool, expected: Color) {
    #expect(rgba(standard.labelColor(isEnabled: isEnabled)) == rgba(expected))
  }

  @Test(arguments: [
    SwitchThumbCase(isOn: false, isPressed: false, diameter: 16, inset: 8),
    SwitchThumbCase(isOn: true, isPressed: false, diameter: 24, inset: 4),
    SwitchThumbCase(isOn: false, isPressed: true, diameter: 28, inset: 2),
    SwitchThumbCase(isOn: true, isPressed: true, diameter: 28, inset: 2)
  ])
  func `the thumb grows when on or pressed`(scenario: SwitchThumbCase) {
    let metrics = DSSwitchMetrics(scale: 1)
    #expect(metrics.thumbDiameter(isOn: scenario.isOn, isPressed: scenario.isPressed) == scenario.diameter)
    #expect(metrics.thumbInset(isOn: scenario.isOn, isPressed: scenario.isPressed) == scenario.inset)
  }

  @Test(arguments: [
    (CGFloat(1), CGFloat(52), CGFloat(32)),
    (CGFloat(1.5), CGFloat(78), CGFloat(48)),
    (CGFloat(2), CGFloat(104), CGFloat(64))
  ])
  func `the track scales with dynamic type`(scale: CGFloat, width: CGFloat, height: CGFloat) {
    let metrics = DSSwitchMetrics(scale: scale)
    #expect(metrics.trackWidth == width)
    #expect(metrics.trackHeight == height)
  }
}
