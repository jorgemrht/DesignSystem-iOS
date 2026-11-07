import Foundation
@testable import JDesignSystem
import Testing

enum TestField: CaseIterable {
  case name
  case email
  case password
}

struct NeighborCase: Sendable {
  let field: TestField
  let order: [TestField]
  let expected: TestField?
}

struct FirstInvalidCase: Sendable {
  let invalid: [TestField]
  let expected: TestField?
}

struct FirstInvalidOrderCase: Sendable {
  let invalid: [TestField]
  let order: [TestField]
  let expected: TestField?
}

struct AllRulesCase: Sendable {
  let value: String
  let expected: DSValidationResult
}

struct ResultCase: Sendable {
  let result: DSValidationResult
  let isValid: Bool
  let message: LocalizedStringResource?
}

struct FormValidationTests {
  @Test(arguments: [
    NeighborCase(field: .name, order: [.name, .email, .password], expected: .email),
    NeighborCase(field: .email, order: [.name, .email, .password], expected: .password),
    NeighborCase(field: .password, order: [.name, .email, .password], expected: nil),
    NeighborCase(field: .email, order: [.name, .email], expected: nil),
    NeighborCase(field: .password, order: [.password, .name], expected: .name),
    NeighborCase(field: .email, order: [.name, .password], expected: nil)
  ])
  func `focus moves to the next field of the given order`(scenario: NeighborCase) {
    #expect(scenario.order.element(after: scenario.field) == scenario.expected)
  }

  @Test(arguments: [
    NeighborCase(field: .name, order: [.name, .email, .password], expected: nil),
    NeighborCase(field: .email, order: [.name, .email, .password], expected: .name),
    NeighborCase(field: .password, order: [.name, .email, .password], expected: .email),
    NeighborCase(field: .name, order: [.password, .name], expected: .password),
    NeighborCase(field: .email, order: [.name, .password], expected: nil)
  ])
  func `focus moves to the previous field of the given order`(scenario: NeighborCase) {
    #expect(scenario.order.element(before: scenario.field) == scenario.expected)
  }

  @Test(arguments: [
    FirstInvalidCase(invalid: [], expected: nil),
    FirstInvalidCase(invalid: [.password], expected: .password),
    FirstInvalidCase(invalid: [.password, .email], expected: .email),
    FirstInvalidCase(invalid: [.email, .name, .password], expected: .name)
  ])
  func `the first invalid field follows declaration order`(scenario: FirstInvalidCase) {
    let validation = Self.validation(invalid: scenario.invalid)

    #expect(validation.firstInvalid == scenario.expected)
    #expect(validation.hasErrors == (scenario.expected != nil))
  }

  @Test(arguments: [
    FirstInvalidOrderCase(invalid: [.name, .password], order: [.password, .name, .email], expected: .password),
    FirstInvalidOrderCase(invalid: [.name, .password], order: [.name, .email, .password], expected: .name),
    FirstInvalidOrderCase(invalid: [.email], order: [.name, .password], expected: nil),
    FirstInvalidOrderCase(invalid: [], order: [.name, .email, .password], expected: nil)
  ])
  func `the first invalid field follows the order it is given`(scenario: FirstInvalidOrderCase) {
    let validation = Self.validation(invalid: scenario.invalid)

    #expect(validation.firstInvalid(in: scenario.order) == scenario.expected)
  }

  private static func validation(invalid: [TestField]) -> DSFormValidation<TestField> {
    var validation = DSFormValidation<TestField>()
    let invalidRule = DSValidation<String> { _ in .invalid("Invalid") }
    let validRule = DSValidation<String> { _ in .valid }

    for field in TestField.allCases {
      validation.validate(field, "", using: invalid.contains(field) ? invalidRule : validRule)
    }
    return validation
  }

  @Test
  func `validating stores the result of the rule`() {
    var validation = DSFormValidation<TestField>()
    let rule = DSValidation<String> { $0.isEmpty ? .invalid("Required") : .valid }

    validation.validate(.name, "", using: rule)
    #expect(validation[.name] == .invalid("Required"))

    validation.validate(.name, "Ana", using: rule)
    #expect(validation[.name] == .valid)
  }

  @Test
  func `resetting clears one field or all of them`() {
    var validation = DSFormValidation<TestField>()
    let invalid = DSValidation<String> { _ in .invalid("Invalid") }
    validation.validate(.name, "", using: invalid)
    validation.validate(.email, "", using: invalid)

    validation.reset(.name)
    #expect(validation[.name] == nil)
    #expect(validation[.email] == .invalid("Invalid"))

    validation.reset()
    #expect(!validation.hasErrors)
  }

  @Test(arguments: [
    AllRulesCase(value: "", expected: .invalid("Enter a value")),
    AllRulesCase(value: "ab", expected: .invalid("Use at least 3 characters")),
    AllRulesCase(value: "abc", expected: .valid)
  ])
  func `the first failing rule wins when rules are combined`(scenario: AllRulesCase) {
    let rule = DSValidation<String>.all([
      DSValidation<String> { $0.isEmpty ? .invalid("Enter a value") : .valid },
      DSValidation<String> { $0.count < 3 ? .invalid("Use at least 3 characters") : .valid }
    ])

    #expect(rule.validate(scenario.value) == scenario.expected)
  }

  @Test(arguments: [
    ResultCase(result: .valid, isValid: true, message: nil),
    ResultCase(result: .invalid("Wrong"), isValid: false, message: "Wrong")
  ])
  func `a result exposes validity and message`(scenario: ResultCase) {
    #expect(scenario.result.isValid == scenario.isValid)
    #expect(scenario.result.message == scenario.message)
  }
}
