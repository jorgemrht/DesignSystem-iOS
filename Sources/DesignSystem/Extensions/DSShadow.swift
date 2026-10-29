import SwiftUI

public struct DSShadow: Sendable {
  public let color: Color
  public let radius: CGFloat
  public let x: CGFloat
  public let y: CGFloat

  public init(
    color: Color,
    radius: CGFloat,
    x: CGFloat = 0,
    y: CGFloat
  ) {
    self.color = color
    self.radius = radius
    self.x = x
    self.y = y
  }

  public static let raised = Self(
    color: .dsScrim.opacity(0.2),
    radius: 5,
    y: 5
  )

  public static let floating = Self(
    color: .dsScrim.opacity(0.22),
    radius: 10,
    y: 4
  )
}

extension View {
  func dsShadow(_ shadow: DSShadow?) -> some View {
    self.shadow(
      color: shadow?.color ?? .clear,
      radius: shadow?.radius ?? 0,
      x: shadow?.x ?? 0,
      y: shadow?.y ?? 0
    )
  }
}
