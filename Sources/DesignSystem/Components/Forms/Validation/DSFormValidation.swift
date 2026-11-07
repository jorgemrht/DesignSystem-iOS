public struct DSFormValidation<Field: Hashable & CaseIterable>: Equatable {
  public private(set) var results: [Field: DSValidationResult] = [:]

  public init() {}

  public subscript(field: Field) -> DSValidationResult? {
    results[field]
  }

  public var hasErrors: Bool {
    results.values.contains { !$0.isValid }
  }

  public var firstInvalid: Field? {
    firstInvalid(in: Array(Field.allCases))
  }

  public func firstInvalid(in order: [Field]) -> Field? {
    order.first { results[$0].isInvalid }
  }

  @MainActor
  @discardableResult
  public mutating func validate<Validator: DSValidator>(
    _ field: Field,
    _ value: Validator.Value,
    using validator: Validator
  ) -> DSValidationResult {
    let result = validator.validate(value)
    if results[field] != result {
      results[field] = result
    }
    return result
  }

  public mutating func reset(_ field: Field) {
    results[field] = nil
  }

  public mutating func reset() {
    results.removeAll()
  }
}
