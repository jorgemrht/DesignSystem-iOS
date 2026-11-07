extension Array where Element: Equatable {
  func element(after element: Element) -> Element? {
    firstIndex(of: element).flatMap { index in
      indices.contains(index + 1) ? self[index + 1] : nil
    }
  }

  func element(before element: Element) -> Element? {
    firstIndex(of: element).flatMap { index in
      indices.contains(index - 1) ? self[index - 1] : nil
    }
  }
}
