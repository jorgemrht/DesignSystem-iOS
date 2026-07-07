import SwiftUI

public struct DSTheme: Sendable {
    public let colors: DSColorTheme

    public init(colors: DSColorTheme = .default) {
        self.colors = colors
    }

    public static let `default` = DSTheme(colors: .default)
}
