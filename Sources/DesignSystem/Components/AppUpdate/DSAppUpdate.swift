import Foundation

public struct DSAppUpdate: Sendable {
  public let force: Bool
  public let url: URL

  public init(force: Bool, url: URL) {
    self.force = force
    self.url = url
  }
}

public struct DSUpdateAppTexts: Sendable {
  public let title: LocalizedStringResource
  public let message: LocalizedStringResource
  public let updateButtonTitle: LocalizedStringResource
  public let dismissButtonTitle: LocalizedStringResource

  public init(
    title: LocalizedStringResource,
    message: LocalizedStringResource,
    updateButtonTitle: LocalizedStringResource,
    dismissButtonTitle: LocalizedStringResource
  ) {
    self.title = title
    self.message = message
    self.updateButtonTitle = updateButtonTitle
    self.dismissButtonTitle = dismissButtonTitle
  }
}
