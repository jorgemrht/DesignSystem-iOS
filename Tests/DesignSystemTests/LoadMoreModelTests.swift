@testable import JDesignSystem
import Testing

struct LoadMoreCase: Sendable {
  let isLoading: Bool
  let isVisible: Bool
  let expected: Bool
}

struct LoadMoreModelTests {
  @Test(arguments: [
    LoadMoreCase(isLoading: false, isVisible: true, expected: true),
    LoadMoreCase(isLoading: true, isVisible: true, expected: false),
    LoadMoreCase(isLoading: false, isVisible: false, expected: false),
    LoadMoreCase(isLoading: true, isVisible: false, expected: false)
  ])
  func `the row loads only while idle and visible`(scenario: LoadMoreCase) {
    #expect(DSLoadMoreRow.shouldLoad(isLoading: scenario.isLoading, isVisible: scenario.isVisible) == scenario.expected)
  }
}
