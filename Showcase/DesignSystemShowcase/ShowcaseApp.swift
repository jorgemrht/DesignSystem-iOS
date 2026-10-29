import JDesignSystem
import SwiftUI

@main
struct ShowcaseApp: App {
  @State private var appearance = ShowcaseAppearance.system

  var body: some Scene {
    WindowGroup {
      ShowcaseRootView(appearance: $appearance)
        .preferredColorScheme(appearance.colorScheme)
        .tint(.dsPrimary)
    }
  }
}

enum ShowcaseAppearance: String, CaseIterable, Identifiable {
  case system = "System"
  case light = "Light"
  case dark = "Dark"

  var id: Self {
    self
  }

  var colorScheme: ColorScheme? {
    switch self {
    case .system: nil
    case .light: .light
    case .dark: .dark
    }
  }
}
