import SwiftUI

public extension View {
  func dsKeepsClearOfFold() -> some View {
    modifier(FoldClearance())
  }
}

private struct FoldClearance: ViewModifier {
  @State private var divisionFrame: CGRect?

  private var leadingClearance: CGFloat {
    guard let divisionFrame, divisionFrame.height > divisionFrame.width else {
      return 0
    }
    return divisionFrame.maxX
  }

  private var topClearance: CGFloat {
    guard let divisionFrame, divisionFrame.width >= divisionFrame.height else {
      return 0
    }
    return divisionFrame.maxY
  }

  func body(content: Content) -> some View {
    content
      .padding(.leading, leadingClearance)
      .padding(.top, topClearance)
      .onGeometryChange(for: CGRect?.self) { proxy in
        Self.activeDivisionFrame(in: proxy)
      } action: { activeDivisionFrame in
        divisionFrame = activeDivisionFrame
      }
  }

  nonisolated private static func activeDivisionFrame(in proxy: GeometryProxy) -> CGRect? {
    #if os(iOS) && !targetEnvironment(macCatalyst)
    guard #available(iOS 27.1, *) else {
      return nil
    }
    return proxy.reservedRegions(kind: .division).first?.frame
    #else
    return nil
    #endif
  }
}
