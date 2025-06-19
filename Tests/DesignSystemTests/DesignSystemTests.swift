import SwiftUI
import Testing
@testable import DesignSystem

@Test
func fontSizeTextStyleMappingIsCorrect() async throws {
  let expected: [(FontSize, Font.TextStyle)] = [
    (.largeTitle, .largeTitle),
    (.title,     .title),
    (.title2,     .title2),
    (.title3,     .title3),
    (.headline,   .headline),
    (.body,       .body),
    (.callout,    .callout),
    (.subheadline, .subheadline),
    (.footnote,   .footnote),
    (.caption1,   .caption),
    (.caption2,   .caption2)
  ]

  for (fontSize, expectedStyle) in expected {
    #expect(fontSize.textStyle == expectedStyle, "Expected \(fontSize.rawValue) to map to \(expectedStyle), got \(fontSize.textStyle)")
  }
}
