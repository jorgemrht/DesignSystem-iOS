import SwiftUI

public enum DSIconButtonProminence: Sendable, CaseIterable {
  case plain
  case bordered
  case primary

  var appearance: DSButtonAppearance {
    switch self {
    case .plain: .plain
    case .bordered: .bordered
    case .primary: .primary
    }
  }
}
