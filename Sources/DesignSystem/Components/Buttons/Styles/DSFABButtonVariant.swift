import SwiftUI

public enum DSFABButtonVariant: Sendable, CaseIterable {
  case primaryContainer
  case secondaryContainer
  case tertiaryContainer

  var appearance: DSButtonAppearance {
    switch self {
    case .primaryContainer: .primaryContainer
    case .secondaryContainer: .secondaryContainer
    case .tertiaryContainer: .tertiaryContainer
    }
  }
}
