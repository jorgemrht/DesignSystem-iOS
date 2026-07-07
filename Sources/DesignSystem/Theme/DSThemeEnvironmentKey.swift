import SwiftUI

private struct DSThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue: DSTheme = .default
}

public extension EnvironmentValues {
    var dsTheme: DSTheme {
        get { self[DSThemeEnvironmentKey.self] }
        set { self[DSThemeEnvironmentKey.self] = newValue }
    }
}
