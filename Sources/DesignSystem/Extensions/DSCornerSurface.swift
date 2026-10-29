import SwiftUI

struct DSCornerSurface: View {
  let cornerStyle: DSCornerStyle
  let fill: Color
  var outline: Color?
  var lineWidth: CGFloat = 1
  var shadow: DSShadow?

  var body: some View {
    switch cornerStyle {
    case .capsule:
      surface(Capsule())
    case let .fixed(radius):
      surface(RoundedRectangle(cornerRadius: radius))
    case let .concentric(minimum):
      surface(ConcentricRectangle(minimumRadius: minimum))
    }
  }

  private func surface(_ shape: some Shape) -> some View {
    shape
      .fill(fill)
      .dsShadow(shadow)
      .overlay {
        if let outline {
          shape.stroke(outline, lineWidth: lineWidth)
        }
      }
  }
}

struct DSCornerClip: ViewModifier {
  let cornerStyle: DSCornerStyle

  func body(content: Content) -> some View {
    switch cornerStyle {
    case .capsule:
      content.clipShape(Capsule())
    case let .fixed(radius):
      content.clipShape(RoundedRectangle(cornerRadius: radius))
    case let .concentric(minimum):
      content.clipShape(ConcentricRectangle(minimumRadius: minimum))
    }
  }
}
