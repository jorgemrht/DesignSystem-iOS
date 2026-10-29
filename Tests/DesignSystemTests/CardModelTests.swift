@testable import JDesignSystem
import SwiftUI
import Testing

struct CardVariantCase: Sendable {
  let variant: DSCardVariant
  let container: Color
  let outline: Color?
  let hasShadow: Bool
}

struct CardModelTests {
  private let standard = DSCardAppearance.standard

  @Test func `variants list every case`() {
    #expect(DSCardVariant.allCases == [.filled, .elevated, .outlined])
  }

  @Test(arguments: [
    CardVariantCase(variant: .filled, container: .dsSurfaceVariant, outline: nil, hasShadow: false),
    CardVariantCase(variant: .elevated, container: .dsSurface, outline: nil, hasShadow: true),
    CardVariantCase(variant: .outlined, container: .dsSurface, outline: .dsOutlineVariant, hasShadow: false)
  ])
  func `standard appearance resolves each variant`(scenario: CardVariantCase) {
    #expect(rgba(standard.containerColor(for: scenario.variant)) == rgba(scenario.container))
    #expect(standard.outlineColor(for: scenario.variant).map { rgba($0) } == scenario.outline.map { rgba($0) })
    #expect((standard.shadow(for: scenario.variant) != nil) == scenario.hasShadow)
  }

  @Test func `the raised shadow is the loading card shadow`() {
    let shadow = DSShadow.raised
    #expect(shadow.radius == 5)
    #expect(shadow.y == 5)
    #expect(shadow.x == 0)
    #expect(rgba(shadow.color) == rgba(.dsScrim.opacity(0.2)))
  }

  @Test func `the inherited variant is filled by default`() {
    #expect(EnvironmentValues().dsCardVariant == .filled)
  }
}
