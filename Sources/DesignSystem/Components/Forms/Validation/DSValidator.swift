import Foundation

public enum DSValidationResult: Sendable, Equatable {
  case valid
  case invalid(LocalizedStringResource)

  public var isValid: Bool {
    switch self {
    case .valid: true
    case .invalid: false
    }
  }

  public var message: LocalizedStringResource? {
    switch self {
    case .valid: nil
    case let .invalid(message): message
    }
  }
}

extension DSValidationResult? {
  var isInvalid: Bool {
    self?.isValid == false
  }
}

@MainActor
public protocol DSValidator<Value> {
  associatedtype Value
  func validate(_ value: Value) -> DSValidationResult
}

public struct DSValidation<Value>: DSValidator {
  private let rule: @MainActor (Value) -> DSValidationResult

  public init(_ rule: @escaping @MainActor (Value) -> DSValidationResult) {
    self.rule = rule
  }

  public func validate(_ value: Value) -> DSValidationResult {
    rule(value)
  }

  public static func all(_ validators: [any DSValidator<Value>]) -> Self {
    Self { value in
      for validator in validators {
        let result = validator.validate(value)
        if !result.isValid {
          return result
        }
      }
      return .valid
    }
  }
}
