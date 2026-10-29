# JDesignSystem

A SwiftUI design system for Apple platforms: themed components, a Material 3 color contract, and tokens for spacing, size, shape and opacity. Every component follows Apple's own patterns (styles, modifiers and environment values), so it reads like SwiftUI.

![Designed for Swift 6.4 and later](https://img.shields.io/badge/Swift-6.4%2B-F05138?logo=swift&logoColor=white)
![Designed for iOS 26 and later](https://img.shields.io/badge/iOS-26%2B-27ae60)
![Designed for macOS 26 and later](https://img.shields.io/badge/macOS-26%2B-2980b9)
![Designed for tvOS 26 and later](https://img.shields.io/badge/tvOS-26%2B-8e44ad)
![Designed for visionOS 26 and later](https://img.shields.io/badge/visionOS-26%2B-e67e22)
![Designed for watchOS 26 and later](https://img.shields.io/badge/watchOS-26%2B-c0392b)
![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange)
![License Apache 2.0](https://img.shields.io/badge/license-Apache_2.0-green)
[![Contact @jorgemrht](https://img.shields.io/badge/Contact-@jorgemrht-95a5a6)](https://github.com/jorgemrht)

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Components](#components)
- [Theme and tokens](#theme-and-tokens)
- [Conventions](#conventions)
- [Example project](#example-project)
- [Tests](#tests)
- [Contributing](#contributing)
- [License](#license)

## Features

- [x] Buttons, glass buttons, text fields, toggles, progress, cards, banners, skeletons and more
- [x] 29 Material 3 color roles resolved from the environment, with light and dark appearances
- [x] One shape, one accent and one variant vocabulary shared by every component
- [x] Corner style, card variant and appearances that a container can set once for everything below
- [x] Dynamic Type, Reduce Motion and VoiceOver aware
- [x] No third-party dependencies, no UIKit or AppKit, no user-facing text of its own
- [x] A demo app that renders every component

## Requirements

| Platform | Minimum | Swift | Installation |
| --- | --- | --- | --- |
| iOS, iPadOS, Mac Catalyst | 26 | 6.4 (Xcode 27) | [Swift Package Manager](#installation) |
| macOS | 26 | 6.4 (Xcode 27) | [Swift Package Manager](#installation) |
| tvOS, watchOS, visionOS | 26 | 6.4 (Xcode 27) | [Swift Package Manager](#installation) |

The library targets version 26 of every platform it supports. It does not need version 27 of any operating system. It is written in Swift 6.4, which is the toolchain that builds the package.

## Installation

In Xcode choose *File > Add Package Dependencies* and enter `https://github.com/jorgemrht/DesignSystem-iOS`. In a `Package.swift`, add the dependency and the product:

```swift
.package(url: "https://github.com/jorgemrht/DesignSystem-iOS", from: "3.0.0")
.product(name: "JDesignSystem", package: "DesignSystem-iOS")
```

## Components

Every name uses the `DS` or `ds` prefix. Styles apply with the matching SwiftUI modifier, so they also reach every control below the view that sets them.

### Buttons

| Component | What it is | Options |
| --- | --- | --- |
| `dsPrimary`, `dsSecondary`, `dsBordered`, `dsTertiary` | Text buttons, one per emphasis level | size (small, medium, large), corner style, appearance; the `.destructive` role switches to the error colors |
| `dsIcon`, `DSIconButton` | Icon-only button | prominence (plain, bordered, primary), size, custom size and font, appearance |
| `dsFAB` | Floating action button | variant (primary, secondary or tertiary container), size, shadow, appearance |
| `dsGlassIcon`, `dsGlassFAB` | Liquid Glass versions of icon and FAB | prominence or variant, size, appearance |
| `DSGlassButtonGroup` | Groups glass buttons so they merge and morph | spacing |

Text buttons follow `controlSize` and `buttonSizing`. Glass buttons are not available on visionOS.

### Inputs

| Component | What it is | Options |
| --- | --- | --- |
| `dsPlainTextField`, `dsTintedTextField`, `dsBorderedTextField`, `dsUnderlinedTextField` | Text field styles | title, message, system symbol, accessory, state, error announcement, corner style, appearance |
| `DSTextFieldAccessory` | Trailing element of a field | clear button, system image, button, text |
| `DSTextArea` | Multi-line input | minimum height, maximum length, character count, state, corner style, appearance |
| `dsSwitch`, `dsCheckbox` | Toggle styles | appearance |

Field state is `normal`, `focused` or `error`.

### Feedback

| Component | What it is | Options |
| --- | --- | --- |
| `DSBanner` | Message anchored to an edge | style (success, warning, error, info), system symbol, optional dismiss |
| `dsBannerStyle` | The banner look for any view | style |
| `dsCircular`, `dsLinear` | Progress styles, determinate or indeterminate | appearance |
| `dsLoading` | Blocks a screen with a progress card | optional message |
| `dsSkeleton` | Turns the view into its own loading placeholder | appearance |
| `dsUpdateApp`, `DSUpdateAppView` | Optional or forced app update prompt | texts, system symbol, actions |

### Layout and content

| Component | What it is | Options |
| --- | --- | --- |
| `dsCard`, `dsCardVariant` | Surface that clips its content | variant (filled, elevated, outlined), corner style, padding, appearance |
| `dsLabel` | Label style | icon edge (leading or trailing), spacing |
| `DSDivider` | Divider in the theme separator color | color |
| `DSLoadMoreRow` | Last row of a paginated list | loading state, load action |
| `dsScreenScroll` | Makes a screen scroll only when its content is taller than the screen | none |
| `dsPadding`, `dsListBackgroundColor`, `dsKeepsClearOfFold` | Spacing, list background and fold avoidance | tokens, color |
| `DSRemoteImage` | Asynchronous image with a failure state | content mode, failure symbol, accessibility label |
| `DSSystemSymbol` | Typed SF Symbol name | none |

## Theme and tokens

The asset catalog is the source of truth for color. `DSColorTheme` is the runtime contract, and `designSystemTheme(_:)` installs a custom `DSTheme` for a whole view tree. Without one, the package assets are used.

| Token | Values |
| --- | --- |
| Color roles | `primary`, `secondary`, `tertiary` and `error`, each with `on…`, `…Container` and `on…Container` roles; `background`, `surface`, `surfaceVariant`, `surfaceTint`, `inverseSurface`, `inversePrimary`, `outline`, `outlineVariant`, `scrim` and their `on…` roles |
| Apple aliases | `dsTint`, `dsLabel`, `dsSecondaryLabel`, `dsSystemBackground`, `dsGroupedBackground`, `dsSystemFill`, `dsSeparator` |
| Spacing | `spacingXXXXS` to `spacingXXL` |
| Size | `controlSizeS` to `controlSizeXL`, `iconSizeM`, `iconSizeL` |
| Corner radius | `cornerRadiusNone` to `cornerRadiusXXL` |
| Corner style | `capsule`, `fixed(_:)`, `concentric(minimum:)` |
| Opacity | disabled, disabled subtle, disabled outline, disabled fill, pressed content, pressed overlay |
| Shadow | `raised`, `floating` |

Colors are named `dsPrimary`, `dsOnSurface` and so on, and resolve the active theme. The Material 3 fixed roles and the newer surface-level roles are intentionally outside the contract.

## Conventions

| Convention | How it works |
| --- | --- |
| Appearance | Toggles, progress, cards, text fields and skeletons have `.standard` and `.tinted(_:)`. Buttons have presets such as `.outlined(_:)`. Pass them with a leading dot, never by naming the type. |
| Corner style | `dsCornerStyle(_:)` on a container changes text buttons, fields, text areas and cards below it. A value passed to a component always wins. |
| Card variant | `dsCardVariant(_:)` on a container sets the variant of every `dsCard()` below it. A variant passed to `dsCard` always wins. |
| Texts and symbols | The package defines no text and no symbol. The app passes every `LocalizedStringResource` and `DSSystemSymbol`. |
| Accessibility | Custom styles keep the behavior of the SwiftUI control they replace. Animations stop with Reduce Motion. |

## Example project

`Showcase/DesignSystemShowcase.xcodeproj` is an app that depends on this package and renders every component, with a light and dark switch. Open it in Xcode and run the `DesignSystemShowcase` scheme for iOS, macOS or visionOS. The `DesignSystemShowcaseTV` and `DesignSystemShowcaseWatch` schemes build the tvOS and watchOS versions.

Opening the package folder only shows the library scheme, which cannot be run.

## Tests

Unit tests use Swift Testing and cover tokens, theme resolution and component models. They do not render views.

```sh
xcodebuild test -scheme JDesignSystem -destination 'platform=iOS Simulator,name=iPhone 18 Pro'
xcodebuild test -scheme JDesignSystem -destination 'platform=macOS'
```

## Contributing

Contributions are welcome. Read [CONTRIBUTING](CONTRIBUTING.md) before opening a pull request, and abide by the [Code of Conduct](CODE_OF_CONDUCT.md).

## License

JDesignSystem is released under the Apache License 2.0. See [LICENSE](LICENSE) and [NOTICE](NOTICE) for details.
