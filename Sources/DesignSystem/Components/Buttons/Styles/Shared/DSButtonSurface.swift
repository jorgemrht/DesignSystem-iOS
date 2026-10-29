import SwiftUI

struct DSButtonSurface<SurfaceShape: Shape>: ViewModifier {
  let visualState: DSButtonVisualState
  let shape: SurfaceShape
  var shadow: DSShadow?

  func body(content: Content) -> some View {
    content
      .background {
        shape.fill(visualState.background)
      }
      .overlay {
        shape.fill(visualState.overlay)
        shape.stroke(visualState.border, lineWidth: visualState.borderWidth)
      }
      .clipShape(shape)
      .contentShape(shape)
      .dsShadow(shadow)
  }
}

#if !os(visionOS)
struct DSGlassButtonSurface: ViewModifier {
  let tint: Color?
  let isInteractive: Bool

  init(appearance: DSButtonAppearance, isEnabled: Bool) {
    tint = isEnabled ? appearance.background : appearance.disabledBackground
    isInteractive = isEnabled
  }

  func body(content: Content) -> some View {
    content
      .contentShape(Circle())
      .glassEffect(Glass.regular.tint(tint).interactive(isInteractive), in: Circle())
  }
}
#endif
