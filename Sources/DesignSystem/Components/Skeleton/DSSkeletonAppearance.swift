import SwiftUI

public struct DSSkeletonAppearance: Sendable {
  public let tint: Color?

  public static let standard = Self(tint: nil)

  public static func tinted(_ color: Color) -> Self {
    Self(tint: color)
  }
}
