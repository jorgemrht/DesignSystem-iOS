import SwiftUI

public struct DSColorTheme: Sendable {
    public let primary: Color
    public let onPrimary: Color
    public let primaryContainer: Color
    public let onPrimaryContainer: Color

    public let secondary: Color
    public let onSecondary: Color
    public let secondaryContainer: Color
    public let onSecondaryContainer: Color

    public let background: Color
    public let onBackground: Color

    public let surface: Color
    public let onSurface: Color
    public let surfaceVariant: Color
    public let onSurfaceVariant: Color

    public let outline: Color
    public let outlineVariant: Color

    public let error: Color
    public let onError: Color

    public init(
        primary: Color,
        onPrimary: Color,
        primaryContainer: Color,
        onPrimaryContainer: Color,
        secondary: Color,
        onSecondary: Color,
        secondaryContainer: Color,
        onSecondaryContainer: Color,
        background: Color,
        onBackground: Color,
        surface: Color,
        onSurface: Color,
        surfaceVariant: Color,
        onSurfaceVariant: Color,
        outline: Color,
        outlineVariant: Color,
        error: Color,
        onError: Color
    ) {
        self.primary = primary
        self.onPrimary = onPrimary
        self.primaryContainer = primaryContainer
        self.onPrimaryContainer = onPrimaryContainer
        self.secondary = secondary
        self.onSecondary = onSecondary
        self.secondaryContainer = secondaryContainer
        self.onSecondaryContainer = onSecondaryContainer
        self.background = background
        self.onBackground = onBackground
        self.surface = surface
        self.onSurface = onSurface
        self.surfaceVariant = surfaceVariant
        self.onSurfaceVariant = onSurfaceVariant
        self.outline = outline
        self.outlineVariant = outlineVariant
        self.error = error
        self.onError = onError
    }
}

public extension DSColorTheme {
    static let `default` = DSColorTheme(
        primary: .dsPrimary,
        onPrimary: .dsOnPrimary,
        primaryContainer: .dsPrimaryContainer,
        onPrimaryContainer: .dsOnPrimaryContainer,
        secondary: .dsSecondary,
        onSecondary: .dsOnSecondary,
        secondaryContainer: .dsSecondaryContainer,
        onSecondaryContainer: .dsOnSecondaryContainer,
        background: .dsBackground,
        onBackground: .dsOnBackground,
        surface: .dsSurface,
        onSurface: .dsOnSurface,
        surfaceVariant: .dsSurfaceVariant,
        onSurfaceVariant: .dsOnSurfaceVariant,
        outline: .dsOutline,
        outlineVariant: .dsOutlineVariant,
        error: .dsError,
        onError: .dsOnError
    )
}
