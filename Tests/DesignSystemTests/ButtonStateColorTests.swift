import Foundation
@testable import JDesignSystem
import SwiftUI
import Testing

struct ButtonStateColorTests {
  @Test func `every appearance resolves the same colors in every state`() {
    let report = ButtonStateColorReport.lines.joined(separator: "\n") + "\n"
    let url = URL(filePath: #filePath)
      .deletingLastPathComponent()
      .appending(path: "References/StateColors/state-colors.txt")
    let reference = try? String(contentsOf: url, encoding: .utf8)
    #expect(reference == report, "state colors differ from References/StateColors/state-colors.txt")
  }

  @Test(arguments: [
    (
      DSButtonAppearance.filled(.dsTertiaryContainer, foreground: .dsOnTertiaryContainer),
      DSButtonAppearance.testTertiaryContainer
    ),
    (
      DSButtonAppearance.filled(.dsPrimaryContainer, foreground: .dsOnPrimaryContainer),
      DSButtonAppearance.testPrimaryContainer
    ),
    (DSButtonAppearance.outlined(.dsError, border: .dsError), DSButtonAppearance.testErrorOutline),
    (DSButtonAppearance.plain(.dsError), DSButtonAppearance.testErrorText)
  ])
  func `appearance factories reproduce the literal appearances`(
    factory: DSButtonAppearance,
    literal: DSButtonAppearance
  ) {
    #expect(ButtonStateColorReport.lines(for: factory) == ButtonStateColorReport.lines(for: literal))
  }

  @Test(arguments: ButtonStateColorReport.appearances)
  func `show borders outlines only the appearances without a visible edge`(
    name: String,
    appearance: DSButtonAppearance
  ) {
    let hidden = ButtonStateColorReport.lines(for: appearance)
    let shown = ButtonStateColorReport.lines(for: appearance, showsBorders: true)
    #expect(hidden.count == shown.count)
    if appearance.background != nil || appearance.border != nil {
      #expect(shown == hidden, "\(name) changed with Show Borders")
      return
    }
    for (hiddenLine, shownLine) in zip(hidden, shown) {
      let colorScheme: ColorScheme = shownLine.hasPrefix("dark") ? .dark : .light
      let outline = ButtonStateColorReport.rgba(.dsOutline, in: colorScheme)
      #expect(shownLine.contains("border=\(outline) "), "\(name) has no outline: \(shownLine)")
      #expect(shownLine.hasSuffix("width=1.0"), "\(name) has no 1 pt edge: \(shownLine)")
      #expect(hiddenLine.hasSuffix("width=0.0"), "\(name) already had an edge: \(hiddenLine)")
    }
  }
}

struct ButtonStateSample {
  let name: String
  let isEnabled: Bool
  let isPressed: Bool

  static let all = [
    Self(name: "enabled", isEnabled: true, isPressed: false),
    Self(name: "pressed", isEnabled: true, isPressed: true),
    Self(name: "disabled", isEnabled: false, isPressed: false),
    Self(name: "disabledPressed", isEnabled: false, isPressed: true)
  ]
}

enum ButtonStateColorReport {
  nonisolated static let appearances: [(String, DSButtonAppearance)] = [
    ("primary", DSButtonHierarchy.primary.appearance(isDestructive: false)),
    ("secondary", DSButtonHierarchy.secondary.appearance(isDestructive: false)),
    ("bordered", DSButtonHierarchy.bordered.appearance(isDestructive: false)),
    ("tertiary", DSButtonHierarchy.tertiary.appearance(isDestructive: false)),
    ("iconPlain", DSIconButtonProminence.plain.appearance),
    ("iconBordered", DSIconButtonProminence.bordered.appearance),
    ("iconBorderedProminent", DSIconButtonProminence.primary.appearance),
    ("fabPrimary", DSFABButtonVariant.primaryContainer.appearance),
    ("fabSecondary", DSFABButtonVariant.secondaryContainer.appearance),
    ("fabTertiary", DSFABButtonVariant.tertiaryContainer.appearance),
    ("customTertiaryContainer", .testTertiaryContainer),
    ("customPrimaryContainer", .testPrimaryContainer),
    ("customErrorOutline", .testErrorOutline),
    ("customErrorText", .testErrorText)
  ]

  static var lines: [String] {
    appearances.flatMap { name, appearance in
      lines(for: appearance).map { "\(name) \($0)" }
    }
  }

  static func lines(for appearance: DSButtonAppearance, showsBorders: Bool = false) -> [String] {
    [ColorScheme.light, .dark].flatMap { colorScheme in
      ButtonStateSample.all.map { sample in
        let visualState = appearance.visualState(
          isEnabled: sample.isEnabled,
          isPressed: sample.isPressed,
          showsBorders: showsBorders
        )
        return "\(colorScheme) \(sample.name) \(describe(visualState, in: colorScheme))"
      }
    }
  }

  static func rgba(_ color: Color, in colorScheme: ColorScheme) -> String {
    var environment = EnvironmentValues()
    environment.colorScheme = colorScheme
    let resolved = color.resolve(in: environment)
    return [resolved.red, resolved.green, resolved.blue, resolved.opacity]
      .map { String(format: "%.4f", Double($0)) }
      .joined(separator: ",")
  }

  private static func describe(_ visualState: DSButtonVisualState, in colorScheme: ColorScheme) -> String {
    let foreground = rgba(visualState.foreground, in: colorScheme)
    let background = rgba(visualState.background, in: colorScheme)
    let border = rgba(visualState.border, in: colorScheme)
    let overlay = rgba(visualState.overlay, in: colorScheme)
    return "fg=\(foreground) bg=\(background) border=\(border) overlay=\(overlay) width=\(visualState.borderWidth)"
  }
}
