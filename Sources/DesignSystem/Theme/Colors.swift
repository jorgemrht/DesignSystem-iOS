import SwiftUI

enum DSDefaultColors {
  static let primary = Color("dsPrimary", bundle: .module)
  static let onPrimary = Color("dsOnPrimary", bundle: .module)
  static let primaryContainer = Color("dsPrimaryContainer", bundle: .module)
  static let onPrimaryContainer = Color("dsOnPrimaryContainer", bundle: .module)
  static let inversePrimary = Color("dsInversePrimary", bundle: .module)
  static let secondary = Color("dsSecondary", bundle: .module)
  static let onSecondary = Color("dsOnSecondary", bundle: .module)
  static let secondaryContainer = Color("dsSecondaryContainer", bundle: .module)
  static let onSecondaryContainer = Color("dsOnSecondaryContainer", bundle: .module)
  static let tertiary = Color("dsTertiary", bundle: .module)
  static let onTertiary = Color("dsOnTertiary", bundle: .module)
  static let tertiaryContainer = Color("dsTertiaryContainer", bundle: .module)
  static let onTertiaryContainer = Color("dsOnTertiaryContainer", bundle: .module)
  static let background = Color("dsBackground", bundle: .module)
  static let onBackground = Color("dsOnBackground", bundle: .module)
  static let surface = Color("dsSurface", bundle: .module)
  static let onSurface = Color("dsOnSurface", bundle: .module)
  static let surfaceVariant = Color("dsSurfaceVariant", bundle: .module)
  static let onSurfaceVariant = Color("dsOnSurfaceVariant", bundle: .module)
  static let surfaceTint = Color("dsSurfaceTint", bundle: .module)
  static let inverseSurface = Color("dsInverseSurface", bundle: .module)
  static let inverseOnSurface = Color("dsInverseOnSurface", bundle: .module)
  static let error = Color("dsError", bundle: .module)
  static let onError = Color("dsOnError", bundle: .module)
  static let errorContainer = Color("dsErrorContainer", bundle: .module)
  static let onErrorContainer = Color("dsOnErrorContainer", bundle: .module)
  static let outline = Color("dsOutline", bundle: .module)
  static let outlineVariant = Color("dsOutlineVariant", bundle: .module)
  static let scrim = Color("dsScrim", bundle: .module)
}

private enum DSColorRole: Hashable, Sendable {
  case primary
  case onPrimary
  case primaryContainer
  case onPrimaryContainer
  case inversePrimary
  case secondary
  case onSecondary
  case secondaryContainer
  case onSecondaryContainer
  case tertiary
  case onTertiary
  case tertiaryContainer
  case onTertiaryContainer
  case background
  case onBackground
  case surface
  case onSurface
  case surfaceVariant
  case onSurfaceVariant
  case surfaceTint
  case inverseSurface
  case inverseOnSurface
  case error
  case onError
  case errorContainer
  case onErrorContainer
  case outline
  case outlineVariant
  case scrim
}

private struct DSThemeColorStyle: ShapeStyle, Hashable, Sendable {
  let role: DSColorRole

  func resolve(in environment: EnvironmentValues) -> Color.Resolved {
    let colors = environment.dsTheme.colors
    let color = switch role {
    case .primary: colors.primary
    case .onPrimary: colors.onPrimary
    case .primaryContainer: colors.primaryContainer
    case .onPrimaryContainer: colors.onPrimaryContainer
    case .inversePrimary: colors.inversePrimary
    case .secondary: colors.secondary
    case .onSecondary: colors.onSecondary
    case .secondaryContainer: colors.secondaryContainer
    case .onSecondaryContainer: colors.onSecondaryContainer
    case .tertiary: colors.tertiary
    case .onTertiary: colors.onTertiary
    case .tertiaryContainer: colors.tertiaryContainer
    case .onTertiaryContainer: colors.onTertiaryContainer
    case .background: colors.background
    case .onBackground: colors.onBackground
    case .surface: colors.surface
    case .onSurface: colors.onSurface
    case .surfaceVariant: colors.surfaceVariant
    case .onSurfaceVariant: colors.onSurfaceVariant
    case .surfaceTint: colors.surfaceTint
    case .inverseSurface: colors.inverseSurface
    case .inverseOnSurface: colors.inverseOnSurface
    case .error: colors.error
    case .onError: colors.onError
    case .errorContainer: colors.errorContainer
    case .onErrorContainer: colors.onErrorContainer
    case .outline: colors.outline
    case .outlineVariant: colors.outlineVariant
    case .scrim: colors.scrim
    }

    return color.resolve(in: environment)
  }
}

public extension Color {
  static let dsPrimary = Color(DSThemeColorStyle(role: .primary))
  static let dsOnPrimary = Color(DSThemeColorStyle(role: .onPrimary))
  static let dsPrimaryContainer = Color(DSThemeColorStyle(role: .primaryContainer))
  static let dsOnPrimaryContainer = Color(DSThemeColorStyle(role: .onPrimaryContainer))
  static let dsInversePrimary = Color(DSThemeColorStyle(role: .inversePrimary))
  static let dsSecondary = Color(DSThemeColorStyle(role: .secondary))
  static let dsOnSecondary = Color(DSThemeColorStyle(role: .onSecondary))
  static let dsSecondaryContainer = Color(DSThemeColorStyle(role: .secondaryContainer))
  static let dsOnSecondaryContainer = Color(DSThemeColorStyle(role: .onSecondaryContainer))
  static let dsTertiary = Color(DSThemeColorStyle(role: .tertiary))
  static let dsOnTertiary = Color(DSThemeColorStyle(role: .onTertiary))
  static let dsTertiaryContainer = Color(DSThemeColorStyle(role: .tertiaryContainer))
  static let dsOnTertiaryContainer = Color(DSThemeColorStyle(role: .onTertiaryContainer))
  static let dsBackground = Color(DSThemeColorStyle(role: .background))
  static let dsOnBackground = Color(DSThemeColorStyle(role: .onBackground))
  static let dsSurface = Color(DSThemeColorStyle(role: .surface))
  static let dsOnSurface = Color(DSThemeColorStyle(role: .onSurface))
  static let dsSurfaceVariant = Color(DSThemeColorStyle(role: .surfaceVariant))
  static let dsOnSurfaceVariant = Color(DSThemeColorStyle(role: .onSurfaceVariant))
  static let dsSurfaceTint = Color(DSThemeColorStyle(role: .surfaceTint))
  static let dsInverseSurface = Color(DSThemeColorStyle(role: .inverseSurface))
  static let dsInverseOnSurface = Color(DSThemeColorStyle(role: .inverseOnSurface))
  static let dsError = Color(DSThemeColorStyle(role: .error))
  static let dsOnError = Color(DSThemeColorStyle(role: .onError))
  static let dsErrorContainer = Color(DSThemeColorStyle(role: .errorContainer))
  static let dsOnErrorContainer = Color(DSThemeColorStyle(role: .onErrorContainer))
  static let dsOutline = Color(DSThemeColorStyle(role: .outline))
  static let dsOutlineVariant = Color(DSThemeColorStyle(role: .outlineVariant))
  static let dsScrim = Color(DSThemeColorStyle(role: .scrim))

  static let dsTint = dsPrimary
  static let dsLabel = dsOnSurface
  static let dsSecondaryLabel = dsOnSurfaceVariant
  static let dsSystemBackground = dsBackground
  static let dsGroupedBackground = dsSurface
  static let dsSystemFill = dsSurfaceVariant
  static let dsSeparator = dsOutlineVariant
}

public extension ShapeStyle where Self == Color {
  static var dsPrimary: Self { Color.dsPrimary }
  static var dsOnPrimary: Self { Color.dsOnPrimary }
  static var dsPrimaryContainer: Self { Color.dsPrimaryContainer }
  static var dsOnPrimaryContainer: Self { Color.dsOnPrimaryContainer }
  static var dsInversePrimary: Self { Color.dsInversePrimary }
  static var dsSecondary: Self { Color.dsSecondary }
  static var dsOnSecondary: Self { Color.dsOnSecondary }
  static var dsSecondaryContainer: Self { Color.dsSecondaryContainer }
  static var dsOnSecondaryContainer: Self { Color.dsOnSecondaryContainer }
  static var dsTertiary: Self { Color.dsTertiary }
  static var dsOnTertiary: Self { Color.dsOnTertiary }
  static var dsTertiaryContainer: Self { Color.dsTertiaryContainer }
  static var dsOnTertiaryContainer: Self { Color.dsOnTertiaryContainer }
  static var dsBackground: Self { Color.dsBackground }
  static var dsOnBackground: Self { Color.dsOnBackground }
  static var dsSurface: Self { Color.dsSurface }
  static var dsOnSurface: Self { Color.dsOnSurface }
  static var dsSurfaceVariant: Self { Color.dsSurfaceVariant }
  static var dsOnSurfaceVariant: Self { Color.dsOnSurfaceVariant }
  static var dsSurfaceTint: Self { Color.dsSurfaceTint }
  static var dsInverseSurface: Self { Color.dsInverseSurface }
  static var dsInverseOnSurface: Self { Color.dsInverseOnSurface }
  static var dsError: Self { Color.dsError }
  static var dsOnError: Self { Color.dsOnError }
  static var dsErrorContainer: Self { Color.dsErrorContainer }
  static var dsOnErrorContainer: Self { Color.dsOnErrorContainer }
  static var dsOutline: Self { Color.dsOutline }
  static var dsOutlineVariant: Self { Color.dsOutlineVariant }
  static var dsScrim: Self { Color.dsScrim }

  static var dsTint: Self { Color.dsTint }
  static var dsLabel: Self { Color.dsLabel }
  static var dsSecondaryLabel: Self { Color.dsSecondaryLabel }
  static var dsSystemBackground: Self { Color.dsSystemBackground }
  static var dsGroupedBackground: Self { Color.dsGroupedBackground }
  static var dsSystemFill: Self { Color.dsSystemFill }
  static var dsSeparator: Self { Color.dsSeparator }
}
