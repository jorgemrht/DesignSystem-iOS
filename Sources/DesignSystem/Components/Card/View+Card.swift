import SwiftUI

public extension EnvironmentValues {
  @Entry var dsCardVariant: DSCardVariant = .filled
}

public extension View {
  func dsCardVariant(_ variant: DSCardVariant) -> some View {
    environment(\.dsCardVariant, variant)
  }

  func dsCard(
    _ variant: DSCardVariant? = nil,
    cornerStyle: DSCornerStyle? = nil,
    padding: CGFloat = .spacingM,
    appearance: DSCardAppearance = .standard
  ) -> some View {
    modifier(DSCardModifier(variant: variant, cornerStyle: cornerStyle, padding: padding, appearance: appearance))
  }
}

private struct DSCardModifier: ViewModifier {
  @Environment(\.dsCardVariant) private var inheritedVariant
  @Environment(\.dsCornerStyle) private var inheritedCornerStyle

  let variant: DSCardVariant?
  let cornerStyle: DSCornerStyle?
  let padding: CGFloat
  let appearance: DSCardAppearance

  func body(content: Content) -> some View {
    let variant = variant ?? inheritedVariant
    let cornerStyle = DSCornerStyle.resolved(
      cornerStyle,
      inherited: inheritedCornerStyle,
      default: .fixed(.cornerRadiusL)
    )

    content
      .padding(padding)
      .modifier(DSCornerClip(cornerStyle: cornerStyle))
      .background {
        DSCornerSurface(
          cornerStyle: cornerStyle,
          fill: appearance.containerColor(for: variant),
          outline: appearance.outlineColor(for: variant),
          shadow: appearance.shadow(for: variant)
        )
      }
  }
}

#if DEBUG
#Preview("Cards") {
  VStack(spacing: .spacingM) {
    ForEach(DSCardVariant.allCases, id: \.self) { variant in
      Text(verbatim: "Card")
        .frame(maxWidth: .infinity, alignment: .leading)
        .dsCard(variant)
    }
  }
  .padding(.spacingS)
  .background(.dsBackground)
}

#Preview("Inherited variant") {
  VStack(spacing: .spacingM) {
    Text(verbatim: "First").frame(maxWidth: .infinity, alignment: .leading).dsCard()
    Text(verbatim: "Second").frame(maxWidth: .infinity, alignment: .leading).dsCard()
    Text(verbatim: "Explicit").frame(maxWidth: .infinity, alignment: .leading).dsCard(.outlined)
  }
  .dsCardVariant(.elevated)
  .padding(.spacingS)
  .background(.dsBackground)
}
#endif
