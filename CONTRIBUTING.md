# Contributing to JDesignSystem

Contributions are welcome: bug reports, fixes, accessibility improvements and new components. Please follow the [Code of Conduct](CODE_OF_CONDUCT.md).

## Reporting a bug

Open an issue with the component, the platform and OS version, the Xcode and Swift versions, and the smallest code that shows the problem. A screenshot helps for visual bugs.

## Proposing a change

Open an issue before writing a new component or changing the public API, so the idea can be agreed before the work is done. Small fixes can go straight to a pull request.

1. Fork the repository and create a branch from `main`.
2. Make the change and add or update the tests.
3. Format and lint with the configuration in the repository: `swiftformat Sources Tests` and `swiftlint lint --quiet`. Change the configuration, with a reason, instead of adding exceptions.
4. Run the tests: `xcodebuild test -scheme JDesignSystem -destination 'platform=macOS'`.
5. Open a pull request that says what changed and why.

## What a change has to respect

- Swift 6.4 and iOS 26 or later, on every platform the package supports. An API newer than 26 needs an `#available` guard.
- No third-party dependencies.
- Reuse before creating: a new look is a variant of an existing base (an enum case or a parameter), not a new type with copied code.
- Keep the public API small. Names follow Apple's terms, with one term per concept across the whole API.
- Everything the code shows is in English, and the source has no comments.
- Tests use Swift Testing, are parameterized with explicit input and expected pairs, and cover logic (models, tokens, theme resolution), not rendering.

## License

By contributing, you agree that your contribution is licensed under the [Apache License 2.0](LICENSE), as the rest of the project.
