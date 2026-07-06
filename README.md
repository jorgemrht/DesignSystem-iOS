# DesignSystem

Swift Package with shared design tokens for Apple platform apps.

## Color Tokens

The color token system and app palette use Material 3 color roles from
https://m3.material.io/styles/color/roles.

The canonical token names are Material 3 role names: `primary`, `onPrimary`,
`primaryContainer`, `surface`, `surfaceContainerHigh`, `outline`, `error`,
`scrim`, `primaryFixed`, and the rest of the M3 `ColorScheme` roles. Apps should
use Swift accessors such as `Color.dsPrimary`, `Color.dsOnPrimary`,
`Color.dsSurface`, `Color.dsSurfaceContainerHigh`, or `Color.dsError` instead of
raw hex values or hue names like blue/gray/red.

Every token is a named color asset with light and dark appearances. SwiftUI
loads the color from the package bundle, so iOS resolves the correct color for
the current appearance.

The source of truth is `Sources/DesignSystem/Resources/Colors.xcassets`.

Color changes must be made in the asset catalog. The library does not depend on
DesignSystemStitch; Stitch or any skill that needs the palette should read the
named colors and Swift accessors from this package.
