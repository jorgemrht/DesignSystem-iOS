# DesignSystem

Swift Package with shared design tokens for Apple platform apps.

## Canonical 29-Role Color Contract

The cross-platform color contract uses the 29 classic Material 3 color roles
from https://m3.material.io/styles/color/roles. Android and Apple
implementations share these canonical role names and semantics:

```text
primary, onPrimary, primaryContainer, onPrimaryContainer, inversePrimary
secondary, onSecondary, secondaryContainer, onSecondaryContainer
tertiary, onTertiary, tertiaryContainer, onTertiaryContainer
background, onBackground
surface, onSurface, surfaceVariant, onSurfaceVariant, surfaceTint
inverseSurface, inverseOnSurface
error, onError, errorContainer, onErrorContainer
outline, outlineVariant, scrim
```

The asset catalog is the canonical token system. `DSColorTheme` is the runtime
contract used by components and consuming apps. Every M3 role has one asset and
one theme property with the same semantic meaning; the `ds` prefix identifies
the packaged Swift color token.

| M3 role | Asset / Swift token | `DSColorTheme` property | Apple-oriented alias | Purpose |
| --- | --- | --- | --- | --- |
| `primary` | `dsPrimary` | `primary` | `dsTint` | Main brand accent for prominent actions, active states, and focus. |
| `onPrimary` | `dsOnPrimary` | `onPrimary` | — | Text and symbols displayed on a primary-colored fill. |
| `primaryContainer` | `dsPrimaryContainer` | `primaryContainer` | — | Lower-emphasis primary container, such as a selected region or tonal control. |
| `onPrimaryContainer` | `dsOnPrimaryContainer` | `onPrimaryContainer` | — | Text and symbols displayed on a primary container. |
| `inversePrimary` | `dsInversePrimary` | `inversePrimary` | — | Primary action color used on an inverse surface, such as an action in a dark transient message. |
| `secondary` | `dsSecondary` | `secondary` | — | Supporting accent for controls or information with less prominence than primary. |
| `onSecondary` | `dsOnSecondary` | `onSecondary` | — | Text and symbols displayed on a secondary-colored fill. |
| `secondaryContainer` | `dsSecondaryContainer` | `secondaryContainer` | — | Lower-emphasis secondary container. |
| `onSecondaryContainer` | `dsOnSecondaryContainer` | `onSecondaryContainer` | — | Text and symbols displayed on a secondary container. |
| `tertiary` | `dsTertiary` | `tertiary` | — | Contrasting accent used to balance the primary and secondary families or draw attention. |
| `onTertiary` | `dsOnTertiary` | `onTertiary` | — | Text and symbols displayed on a tertiary-colored fill. |
| `tertiaryContainer` | `dsTertiaryContainer` | `tertiaryContainer` | — | Lower-emphasis tertiary container, including the tertiary FAB treatment. |
| `onTertiaryContainer` | `dsOnTertiaryContainer` | `onTertiaryContainer` | — | Text and symbols displayed on a tertiary container. |
| `background` | `dsBackground` | `background` | `dsSystemBackground` | Base background of a screen or window. |
| `onBackground` | `dsOnBackground` | `onBackground` | — | Foreground content displayed directly on the base background. |
| `surface` | `dsSurface` | `surface` | `dsGroupedBackground` | Background for grouped content and component surfaces. |
| `onSurface` | `dsOnSurface` | `onSurface` | `dsLabel` | Primary text and symbols displayed on surfaces. |
| `surfaceVariant` | `dsSurfaceVariant` | `surfaceVariant` | `dsSystemFill` | Alternative surface or fill for controls and containers that need separation. |
| `onSurfaceVariant` | `dsOnSurfaceVariant` | `onSurfaceVariant` | `dsSecondaryLabel` | Secondary text, icons, and supporting content on surfaces. |
| `surfaceTint` | `dsSurfaceTint` | `surfaceTint` | — | Tint associated with a surface; Android can use it for tonal elevation. |
| `inverseSurface` | `dsInverseSurface` | `inverseSurface` | — | High-contrast surface with the opposite lightness of the normal surface. |
| `inverseOnSurface` | `dsInverseOnSurface` | `inverseOnSurface` | — | Text and symbols displayed on an inverse surface. |
| `error` | `dsError` | `error` | — | Errors, destructive actions, and critical validation states. |
| `onError` | `dsOnError` | `onError` | — | Text and symbols displayed on an error-colored fill. |
| `errorContainer` | `dsErrorContainer` | `errorContainer` | — | Lower-emphasis container for error messages and validation states. |
| `onErrorContainer` | `dsOnErrorContainer` | `onErrorContainer` | — | Text and symbols displayed on an error container. |
| `outline` | `dsOutline` | `outline` | — | Strong boundaries, focused outlines, and high-emphasis borders. |
| `outlineVariant` | `dsOutlineVariant` | `outlineVariant` | `dsSeparator` | Subtle boundaries and separators between nearby content. |
| `scrim` | `dsScrim` | `scrim` | — | Dimming overlay placed behind modal content, sheets, dialogs, or transient surfaces to separate them from underlying content. |

Each role is stored as a `ds`-prefixed named color asset with light and dark
appearances, such as `dsPrimary`, `dsOnPrimary`, or `dsSurface`. The source of
truth for design tools and agents is
`Sources/DesignSystem/Theme/Resources/Colors.xcassets`.

`DSColorTheme` exposes the same 29 canonical roles. SwiftUI color accessors such
as `Color.dsPrimary` resolve the active `DSTheme` from the environment, falling
back to the package assets through `DSTheme.default`.

For Apple-platform code, `Colors.swift` also provides semantic aliases aligned
with [Apple's color guidance](https://developer.apple.com/design/human-interface-guidelines/color),
[background hierarchy](https://developer.apple.com/documentation/uikit/uicolor/systembackground),
and [system fills](https://developer.apple.com/documentation/uikit/uicolor/secondarysystemfill):
`dsTint`, `dsLabel`, `dsSecondaryLabel`, `dsSystemBackground`,
`dsGroupedBackground`, `dsSystemFill`, and `dsSeparator`. These aliases preserve
the shared palette while giving SwiftUI call sites platform-appropriate
vocabulary.

### Global theme and component appearance overrides

After the app declares its own `DSTheme.example`, install it once above
the app's content. Every default component appearance resolves its semantic
colors from that environment automatically:

```swift
import JDesignSystem

RootView()
  .designSystemTheme(.example)
```

A button using its standard appearance needs no additional color input:

```swift
Button("Continue") {
  continueAction()
}
.buttonStyle(.JdsPrimary(size: .medium))
```

When an app needs a reusable component-specific treatment, define named
appearances in the app's DesignSystem wrapper using the semantic `.ds...`
tokens. Those colors already resolve the active theme, so the appearance does
not receive or store a separate palette:

```swift
import JDesignSystem

public extension JdsButtonAppearance {
  static func examplePrimary() -> Self {
    Self(
      foreground: .dsOnPrimary,
      background: .dsPrimary,
      pressedOverlay: .dsOnPrimary,
      disabledForeground: .dsOnPrimary.opacity(0.55),
      disabledBackground: .dsPrimary.opacity(0.38)
    )
  }

  static func exampleBordered() -> Self {
    Self(
      foreground: .dsPrimary,
      background: nil,
      border: .dsOutline,
      pressedOverlay: .dsPrimary,
      disabledForeground: .dsPrimary.opacity(0.38),
      disabledBackground: nil,
      disabledBorder: .dsPrimary.opacity(0.24)
    )
  }

  static func exampleIcon() -> Self {
    Self(
      foreground: .dsOnSurfaceVariant,
      background: nil,
      pressedOverlay: .dsOnSurfaceVariant,
      disabledForeground: .dsOnSurfaceVariant.opacity(0.38),
      disabledBackground: nil,
      disabledBorder: nil
    )
  }
}
```

Apply the named appearance directly. No environment read or color argument is
needed at the call site:

```swift
import SwiftUI
import JDesignSystem

struct ExampleView: View {
  var body: some View {
    Button("Continue") {
      continueAction()
    }
    .buttonStyle(
      .JdsPrimary(
        size: .medium,
        appearance: .examplePrimary()
      )
    )
  }

  private func continueAction() {
    // Perform the app action.
  }
}
```

This preserves the component API and its stored `appearance`: the global theme
provides the normal defaults, while the explicit appearance replaces only the
button treatment selected by the app.

The 12 Material fixed roles and the seven newer Material surface-level roles
are intentionally outside the package theme contract. This Swift package does
not need to mirror Android's complete `ColorScheme`; an Android implementation
can provide its own equivalent extensions. A Swift app that genuinely needs a
fixed color or additional surface hierarchy can define app-level tokens or use
the component appearance overrides without expanding the common 29-role theme.

Color changes must keep the canonical asset names stable. Apps should use the
theme accessors instead of raw hex values or hue names such as blue, gray, or
red. External design tools can update the same named assets, but the package
itself has no dependency on those tools.

## Typography Scale

Text that uses `font(size:weight:)` and text inside JDesignSystem components can
be scaled from a common environment value. The standard scale preserves the
system semantic font sizes:

```swift
ContentView()
  .jdsTypographyScale(.standard)
```

Three predefined scales are available for common settings interfaces:

```swift
.jdsTypographyScale(.small)
.jdsTypographyScale(.standard)
.jdsTypographyScale(.large)
```

Apps that offer a slider or another continuous control can provide a custom
positive factor. Invalid, non-finite, and non-positive factors resolve to the
standard scale:

```swift
ContentView()
  .jdsTypographyScale(.custom(1.25))
```

The scale multiplies semantic text styles instead of replacing them with fixed
point sizes, preserving the system typographic hierarchy and accessibility
behavior. Preference storage and the settings interface remain the
responsibility of the consuming app.
