import SwiftUI

public extension View {
  func dsPadding(_ spacing: CGFloat) -> some View {
    padding(spacing)
  }

  func dsPadding(
    top: CGFloat = 0,
    leading: CGFloat = 0,
    bottom: CGFloat = 0,
    trailing: CGFloat = 0
  ) -> some View {
    padding(.ds(top: top, leading: leading, bottom: bottom, trailing: trailing))
  }

  func dsPadding(vertical: CGFloat, horizontal: CGFloat) -> some View {
    padding(.ds(vertical: vertical, horizontal: horizontal))
  }

  func dsPadding(top: CGFloat = 0, bottom: CGFloat = 0, horizontal: CGFloat) -> some View {
    padding(.ds(top: top, bottom: bottom, horizontal: horizontal))
  }

  func dsPadding(leading: CGFloat = 0, trailing: CGFloat = 0, vertical: CGFloat) -> some View {
    padding(.ds(leading: leading, trailing: trailing, vertical: vertical))
  }
}

private extension EdgeInsets {
  static func ds(
    top: CGFloat = 0,
    leading: CGFloat = 0,
    bottom: CGFloat = 0,
    trailing: CGFloat = 0
  ) -> Self {
    .init(top: top, leading: leading, bottom: bottom, trailing: trailing)
  }

  static func ds(vertical: CGFloat, horizontal: CGFloat) -> Self {
    .ds(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
  }

  static func ds(top: CGFloat = 0, bottom: CGFloat = 0, horizontal: CGFloat) -> Self {
    .ds(top: top, leading: horizontal, bottom: bottom, trailing: horizontal)
  }

  static func ds(leading: CGFloat = 0, trailing: CGFloat = 0, vertical: CGFloat) -> Self {
    .ds(top: vertical, leading: leading, bottom: vertical, trailing: trailing)
  }
}

#if DEBUG
#Preview {
  VStack(spacing: .spacingM) {
    Text(verbatim: "Directional")
      .font(.headline)
      .foregroundStyle(.dsOnPrimaryContainer)
      .dsPadding(top: .spacingXS, leading: .spacingM, bottom: .spacingXS, trailing: .spacingL)
      .background(.dsPrimaryContainer, in: .rect(cornerRadius: .spacingXS))

    Text(verbatim: "Axis")
      .font(.headline)
      .foregroundStyle(.dsOnSecondaryContainer)
      .dsPadding(vertical: .spacingS, horizontal: .spacingL)
      .background(.dsSecondaryContainer, in: .rect(cornerRadius: .spacingXS))
  }
  .dsPadding(vertical: .spacingL, horizontal: .spacingM)
  .background(.dsSurface)
}
#endif
