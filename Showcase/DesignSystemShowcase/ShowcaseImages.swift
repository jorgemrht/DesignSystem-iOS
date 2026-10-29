import JDesignSystem
import SwiftUI

struct RemoteImageShowcase: View {
  var body: some View {
    ShowcasePage {
      if let url = URL(string: "https://picsum.photos/id/10/400") {
        ShowcaseGroup(title: "Loaded") {
          DSRemoteImage(url: url, failureSymbol: .photo, accessibilityLabel: "Sample image")
            .frame(width: 120, height: 120)
        }
      }

      if let url = URL(string: "https://example.com/missing.png") {
        ShowcaseGroup(title: "Load error") {
          DSRemoteImage(url: url, failureSymbol: .photo, accessibilityLabel: "Sample image")
            .frame(width: 120, height: 120)
            .background(.dsSurfaceVariant, in: .rect(cornerRadius: .cornerRadiusM))
        }
      }
    }
  }
}
