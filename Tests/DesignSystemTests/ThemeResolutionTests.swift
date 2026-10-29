import JDesignSystem
import SwiftUI
import Testing

struct AliasPair: Sendable {
  let alias: Color
  let role: Color

  nonisolated static let all = [
    Self(alias: .dsTint, role: .dsPrimary),
    Self(alias: .dsLabel, role: .dsOnSurface),
    Self(alias: .dsSecondaryLabel, role: .dsOnSurfaceVariant),
    Self(alias: .dsSystemBackground, role: .dsBackground),
    Self(alias: .dsGroupedBackground, role: .dsSurface),
    Self(alias: .dsSystemFill, role: .dsSurfaceVariant),
    Self(alias: .dsSeparator, role: .dsOutlineVariant)
  ]
}

struct ThemeResolutionTests {
  @Test func `default theme resolves the asset catalog colors`() {
    let primaryLight = rgba(.dsPrimary, in: .light)
    #expect(primaryLight[3] == 1)
    #expect(rgba(.dsPrimary, in: .light) != rgba(.dsPrimary, in: .dark))
    #expect(rgba(.dsSurface, in: .light) != rgba(.dsSurface, in: .dark))
  }

  @Test func `a custom theme replaces every role it defines`() {
    let theme = DSTheme(colors: .uniform(.green, primary: .red))
    #expect(isClose(rgba(.dsPrimary, theme: theme), rgba(.red)))
    #expect(isClose(rgba(.dsOnPrimary, theme: theme), rgba(.green)))
    #expect(isClose(rgba(.dsScrim, in: .dark, theme: theme), rgba(.green, in: .dark)))
    #expect(rgba(.dsPrimary, theme: theme) != rgba(.dsPrimary))
  }

  @Test(arguments: AliasPair.all, [ColorScheme.light, .dark])
  func `apple oriented aliases resolve to their role`(pair: AliasPair, scheme: ColorScheme) {
    let theme = DSTheme(colors: .uniform(.blue, primary: .orange))
    #expect(rgba(pair.alias, in: scheme) == rgba(pair.role, in: scheme))
    #expect(rgba(pair.alias, in: scheme, theme: theme) == rgba(pair.role, in: scheme, theme: theme))
  }

  @Test func `shape style accessors match the color accessors`() {
    let styled: [(Color, Color)] = [
      (.dsPrimary, Color.dsPrimary),
      (.dsError, Color.dsError),
      (.dsOutline, Color.dsOutline)
    ]
    for (lhs, rhs) in styled {
      #expect(rgba(lhs) == rgba(rhs))
    }
  }

  @Test func `default color theme maps each role to its own asset`() {
    let colors = DSColorTheme.default
    let roles: [Color] = [
      colors.primary, colors.onPrimary, colors.primaryContainer, colors.onPrimaryContainer,
      colors.inversePrimary, colors.secondary, colors.onSecondary, colors.secondaryContainer,
      colors.onSecondaryContainer, colors.tertiary, colors.onTertiary, colors.tertiaryContainer,
      colors.onTertiaryContainer, colors.background, colors.onBackground, colors.surface,
      colors.onSurface, colors.surfaceVariant, colors.onSurfaceVariant, colors.surfaceTint,
      colors.inverseSurface, colors.inverseOnSurface, colors.error, colors.onError,
      colors.errorContainer, colors.onErrorContainer, colors.outline, colors.outlineVariant,
      colors.scrim
    ]
    #expect(roles.count == 29)
    #expect(isClose(rgba(colors.primary), rgba(.dsPrimary)))
    #expect(isClose(rgba(colors.error, in: .dark), rgba(.dsError, in: .dark)))
  }

  @Test func `theme defaults are shared by the environment`() {
    #expect(EnvironmentValues().dsTheme.colors.primary == DSTheme.default.colors.primary)
  }
}
