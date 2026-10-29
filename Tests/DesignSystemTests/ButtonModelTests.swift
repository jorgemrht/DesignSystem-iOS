@testable import JDesignSystem
import SwiftUI
import Testing

struct DynamicTypeCase: Sendable {
  let scale: CGFloat
  let multiplier: CGFloat
}

struct ButtonModelTests {
  @Test(arguments: [
    (ControlSize.mini, DSButtonSize.small),
    (ControlSize.small, DSButtonSize.small),
    (ControlSize.regular, DSButtonSize.medium),
    (ControlSize.large, DSButtonSize.large),
    (ControlSize.extraLarge, DSButtonSize.large)
  ])
  func `control size maps to the matching button size`(controlSize: ControlSize, expected: DSButtonSize) {
    #expect(DSButtonSize(controlSize) == expected)
  }

  @Test func `button sizes grow with every metric`() {
    let sizes = DSButtonSize.allCases
    #expect(sizes == [.small, .medium, .large])
    #expect(sizes.map(\.minHeight) == sizes.map(\.minHeight).sorted())
    #expect(sizes.map(\.horizontalPadding) == sizes.map(\.horizontalPadding).sorted())
    #expect(sizes.map(\.iconButtonDiameter) == sizes.map(\.iconButtonDiameter).sorted())
    #expect(sizes.map(\.fabDiameter) == sizes.map(\.fabDiameter).sorted())
    #expect(sizes.allSatisfy { $0.minHeight >= 44 && $0.iconButtonDiameter >= 44 && $0.fabDiameter >= 44 })
  }

  @Test(arguments: DSButtonSize.allCases, [
    DynamicTypeCase(scale: 0.5, multiplier: 1),
    DynamicTypeCase(scale: 1, multiplier: 1),
    DynamicTypeCase(scale: 2, multiplier: 2),
    DynamicTypeCase(scale: 3, multiplier: 3)
  ])
  func `dynamic type only ever grows the circular buttons`(size: DSButtonSize, scenario: DynamicTypeCase) {
    #expect(DSCircularVariant.icon.diameter(for: size, scaledBy: scenario.scale) == size.minHeight * scenario
      .multiplier)
    #expect(DSCircularVariant.fab.diameter(for: size, scaledBy: scenario.scale) == size.fabDiameter * scenario
      .multiplier)
  }

  @Test(arguments: DSButtonSize.allCases)
  func `circular kinds keep a FAB at least as large as the icon button`(size: DSButtonSize) {
    let fab = DSCircularVariant.fab.diameter(for: size, scaledBy: 1)
    let icon = DSCircularVariant.icon.diameter(for: size, scaledBy: 1)
    #expect(fab >= icon)
  }

  @Test(arguments: [
    (DSButtonHierarchy.primary, DSButtonAppearance.primary),
    (DSButtonHierarchy.secondary, DSButtonAppearance.secondary),
    (DSButtonHierarchy.bordered, DSButtonAppearance.bordered),
    (DSButtonHierarchy.tertiary, DSButtonAppearance.tertiary)
  ])
  func `hierarchies resolve their own appearance`(hierarchy: DSButtonHierarchy, expected: DSButtonAppearance) {
    #expect(
      ButtonStateColorReport.lines(for: hierarchy.appearance(isDestructive: false))
        == ButtonStateColorReport.lines(for: expected)
    )
  }

  @Test(arguments: [
    (DSButtonHierarchy.primary, DSButtonAppearance.destructivePrimary),
    (DSButtonHierarchy.secondary, DSButtonAppearance.destructiveSecondary),
    (DSButtonHierarchy.bordered, DSButtonAppearance.destructiveBordered),
    (DSButtonHierarchy.tertiary, DSButtonAppearance.destructiveTertiary)
  ])
  func `destructive hierarchies resolve their own appearance and differ from the regular ones`(
    hierarchy: DSButtonHierarchy,
    expected: DSButtonAppearance
  ) {
    let resolved = ButtonStateColorReport.lines(for: hierarchy.appearance(isDestructive: true))
    #expect(resolved == ButtonStateColorReport.lines(for: expected))
    #expect(resolved != ButtonStateColorReport.lines(for: hierarchy.appearance(isDestructive: false)))
  }

  @Test func `destructive appearances use the error roles`() {
    #expect(rgba(DSButtonAppearance.destructivePrimary.background ?? .clear) == rgba(.dsError))
    #expect(rgba(DSButtonAppearance.destructivePrimary.foreground) == rgba(.dsOnError))
    #expect(rgba(DSButtonAppearance.destructiveTertiary.foreground) == rgba(.dsError))
  }

  @Test func `icon prominence and fab variants cover every case`() {
    #expect(DSIconButtonProminence.allCases == [.plain, .bordered, .primary])
    #expect(DSFABButtonVariant.allCases == [.primaryContainer, .secondaryContainer, .tertiaryContainer])
    #expect(DSIconButtonProminence.plain.appearance.background == nil)
    #expect(DSIconButtonProminence.bordered.appearance.border != nil)
    #expect(DSIconButtonProminence.primary.appearance.background != nil)
  }

  @Test(arguments: DSFABButtonVariant.allCases)
  func `every fab variant has a background`(variant: DSFABButtonVariant) {
    #expect(variant.appearance.background != nil)
  }

  @Test func `visual state follows enabled pressed and disabled`() {
    let appearance = DSButtonAppearance.primary
    let enabled = appearance.visualState(isEnabled: true, isPressed: false)
    let pressed = appearance.visualState(isEnabled: true, isPressed: true)
    let disabled = appearance.visualState(isEnabled: false, isPressed: false)
    let disabledPressed = appearance.visualState(isEnabled: false, isPressed: true)

    #expect(rgba(enabled.overlay)[3] == 0)
    #expect(rgba(pressed.overlay)[3] > 0)
    #expect(rgba(disabled.overlay)[3] == 0)
    #expect(rgba(disabledPressed.overlay)[3] == 0)
    #expect(rgba(disabled.foreground) != rgba(enabled.foreground))
    #expect(rgba(disabledPressed.foreground) == rgba(disabled.foreground))
  }

  @Test func `border width is one point only when a border exists`() {
    let bordered = DSButtonAppearance.bordered.visualState(isEnabled: true, isPressed: false)
    let filled = DSButtonAppearance.primary.visualState(isEnabled: true, isPressed: false)
    #expect(bordered.borderWidth == 1)
    #expect(filled.borderWidth == 0)
  }

  @Test func `text appearances dim the label while pressed`() {
    let normal = DSButtonAppearance.tertiary.visualState(isEnabled: true, isPressed: false)
    let pressed = DSButtonAppearance.tertiary.visualState(isEnabled: true, isPressed: true)
    #expect(rgba(pressed.foreground)[3] < rgba(normal.foreground)[3])
    #expect(rgba(pressed.overlay)[3] == 0)
  }

  @Test func `appearance initializer applies the documented defaults`() {
    let appearance = DSButtonAppearance(foreground: .red, background: .blue, pressedOverlay: .red)
    #expect(appearance.pressedOverlayOpacity == 0.10)
    #expect(appearance.pressedForeground == nil)
    #expect(appearance.border == nil)
    #expect(appearance.disabledBorder == nil)
    #expect(rgba(appearance.disabledForeground) == rgba(DSButtonAppearance.disabledForeground))
  }

  @Test func `floating shadow is offset below the button`() {
    let shadow = DSShadow.floating
    #expect(shadow.x == 0)
    #expect(shadow.y == 4)
    #expect(shadow.radius == 10)
    #expect(DSShadow(color: .black, radius: 3, y: 1).x == 0)
  }
}
