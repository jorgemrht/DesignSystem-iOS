import SwiftUI

enum DSCircularVariant {
  case icon
  case fab

  static func scaled(_ dimension: CGFloat, by dynamicTypeScale: CGFloat) -> CGFloat {
    max(dimension, dimension * dynamicTypeScale)
  }

  func diameter(for size: DSButtonSize, scaledBy dynamicTypeScale: CGFloat) -> CGFloat {
    switch self {
    case .icon: Self.scaled(size.iconButtonDiameter, by: dynamicTypeScale)
    case .fab: Self.scaled(size.fabDiameter, by: dynamicTypeScale)
    }
  }

  func font(for size: DSButtonSize, scaledBy dynamicTypeScale: CGFloat) -> Font {
    switch self {
    case .icon: size.iconButtonFont
    case .fab: .system(size: Self.scaled(size.fabIconSize, by: dynamicTypeScale))
    }
  }
}

struct DSCircularButtonLabel: View {
  @Environment(\.controlSize) private var controlSize
  @ScaledMetric(relativeTo: .body) private var dynamicTypeScale: CGFloat = 1

  let label: ButtonStyleConfiguration.Label
  let variant: DSCircularVariant
  let size: DSButtonSize?
  let foreground: Color
  var customDiameter: CGFloat?
  var customFont: Font?

  var body: some View {
    let size = size ?? DSButtonSize(controlSize)
    let diameter = customDiameter.map { DSCircularVariant.scaled($0, by: dynamicTypeScale) }
      ?? variant.diameter(for: size, scaledBy: dynamicTypeScale)
    label
      .labelStyle(.iconOnly)
      .font(customFont ?? variant.font(for: size, scaledBy: dynamicTypeScale))
      .foregroundStyle(foreground)
      .frame(width: diameter, height: diameter)
  }
}
