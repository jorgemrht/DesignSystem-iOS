import CoreGraphics
import SwiftUI

public enum JdsButtonSize: Sendable {
  case small
  case medium
  case large

  var minHeight: CGFloat {
    switch self {
    case .small: 44
    case .medium: 48
    case .large: 56
    }
  }

  var horizontalPadding: CGFloat {
    switch self {
    case .small: .spacingS
    case .medium: .spacingM
    case .large: .spacingL
    }
  }

  var labelFont: Font {
    switch self {
    case .small: .callout
    case .medium, .large: .body
    }
  }
}

public struct JdsButtonShadow: Sendable {
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

  public static let floating = JdsButtonShadow(
    color: .dsScrim.opacity(0.22),
    radius: 10,
    y: 4
  )
}

struct ButtonAppearance: Sendable {
  let foreground: Color
  let container: Color?
  let border: Color?
  let pressedOverlay: Color
  let disabledForeground: Color
  let disabledContainer: Color?
  let disabledBorder: Color?
  let shadow: JdsButtonShadow?

  init(
    foreground: Color,
    container: Color?,
    border: Color? = nil,
    pressedOverlay: Color,
    disabledForeground: Color = .dsOnSurface.opacity(0.38),
    disabledContainer: Color? = .dsOnSurface.opacity(0.12),
    disabledBorder: Color? = nil,
    shadow: JdsButtonShadow? = nil
  ) {
    self.foreground = foreground
    self.container = container
    self.border = border
    self.pressedOverlay = pressedOverlay
    self.disabledForeground = disabledForeground
    self.disabledContainer = disabledContainer
    self.disabledBorder = disabledBorder
    self.shadow = shadow
  }

  static let prominent = ButtonAppearance(
    foreground: .dsOnPrimary,
    container: .dsPrimary,
    pressedOverlay: .dsOnPrimary
  )

  static let standard = ButtonAppearance(
    foreground: .dsOnSecondaryContainer,
    container: .dsSecondaryContainer,
    pressedOverlay: .dsOnSecondaryContainer
  )

  static let bordered = ButtonAppearance(
    foreground: .dsPrimary,
    container: nil,
    border: .dsOutline,
    pressedOverlay: .dsPrimary,
    disabledContainer: nil,
    disabledBorder: .dsOnSurface.opacity(0.12)
  )

  static let plain = ButtonAppearance(
    foreground: .dsPrimary,
    container: nil,
    pressedOverlay: .dsPrimary,
    disabledContainer: nil
  )
}

struct ButtonAppearanceModifier: ViewModifier {
  @Environment(\.isEnabled) private var isEnabled

  let appearance: ButtonAppearance
  let size: JdsButtonSize
  let isFullWidth: Bool
  let cornerRadius: CGFloat
  let isPressed: Bool
  let pressedOverlayOpacity: Double

  func body(content: Content) -> some View {
    let foreground = isEnabled ? appearance.foreground : appearance.disabledForeground
    let container = isEnabled ? appearance.container : appearance.disabledContainer
    let border = isEnabled ? appearance.border : appearance.disabledBorder
    let shadow = isEnabled ? appearance.shadow : nil
    let shape = RoundedRectangle(cornerRadius: cornerRadius)

    content
      .font(size.labelFont)
      .multilineTextAlignment(.center)
      .foregroundStyle(foreground)
      .padding(.horizontal, size.horizontalPadding)
      .frame(maxWidth: isFullWidth ? .infinity : nil)
      .frame(minHeight: size.minHeight)
      .background {
        if let container {
          shape.fill(container)
        }
      }
      .overlay {
        shape
          .fill(appearance.pressedOverlay.opacity(isEnabled && isPressed ? pressedOverlayOpacity : 0))
      }
      .overlay {
        if let border {
          shape.stroke(border, lineWidth: 1)
        }
      }
      .clipShape(shape)
      .contentShape(shape)
      .shadow(
        color: shadow?.color ?? .clear,
        radius: shadow?.radius ?? 0,
        x: shadow?.x ?? 0,
        y: shadow?.y ?? 0
      )
  }
}
