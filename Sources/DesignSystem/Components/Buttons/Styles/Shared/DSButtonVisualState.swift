import SwiftUI

struct DSButtonVisualState {
  let foreground: Color
  let background: Color
  let border: Color
  let borderWidth: CGFloat
  let overlay: Color
}

extension DSButtonAppearance {
  func visualState(isEnabled: Bool, isPressed: Bool, showsBorders: Bool = false) -> DSButtonVisualState {
    let resolvedForeground = if !isEnabled {
      disabledForeground
    } else if isPressed {
      pressedForeground ?? foreground
    } else {
      foreground
    }
    let resolvedBackground = isEnabled ? background : disabledBackground
    let stateBorder = isEnabled ? border : disabledBorder
    let needsVisibleEdge = showsBorders && background == nil && border == nil
    let resolvedBorder = needsVisibleEdge ? Color.dsOutline : stateBorder
    let resolvedOverlay = isEnabled && isPressed
      ? pressedOverlay.opacity(pressedOverlayOpacity)
      : .clear

    return DSButtonVisualState(
      foreground: resolvedForeground,
      background: resolvedBackground ?? .clear,
      border: resolvedBorder ?? .clear,
      borderWidth: resolvedBorder == nil ? 0 : 1,
      overlay: resolvedOverlay
    )
  }
}
