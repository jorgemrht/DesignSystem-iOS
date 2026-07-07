import SwiftUI

public struct JdsSystemSymbol: RawRepresentable, Sendable, Hashable, ExpressibleByStringLiteral {
  public let rawValue: String

  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  public init(_ rawValue: String) {
    self.rawValue = rawValue
  }

  public init(stringLiteral value: String) {
    self.rawValue = value
  }
}

public extension JdsSystemSymbol {
  static let magnifyingglass = Self("magnifyingglass")
  static let plus = Self("plus")
  static let xmark = Self("xmark")
}

public extension Image {
  init(systemSymbol: JdsSystemSymbol) {
    self.init(systemName: systemSymbol.rawValue)
  }
}
