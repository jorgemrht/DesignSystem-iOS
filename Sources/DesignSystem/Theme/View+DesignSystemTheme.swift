import SwiftUI

public extension View {
    func designSystemTheme(_ theme: DSTheme) -> some View {
        environment(\.dsTheme, theme)
    }
}
