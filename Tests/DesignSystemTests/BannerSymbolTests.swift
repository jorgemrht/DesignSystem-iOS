@testable import JDesignSystem
import SwiftUI
import Testing

struct BannerSymbolTests {
  @Test func `banner styles map to distinct theme roles`() {
    #expect(DSBannerStyle.allCases == [.success, .warning, .error, .info])
    #expect(rgba(DSBannerStyle.success.background) == rgba(.dsTertiaryContainer))
    #expect(rgba(DSBannerStyle.success.foreground) == rgba(.dsOnTertiaryContainer))
    #expect(rgba(DSBannerStyle.warning.background) == rgba(.dsSecondaryContainer))
    #expect(rgba(DSBannerStyle.warning.foreground) == rgba(.dsOnSecondaryContainer))
    #expect(rgba(DSBannerStyle.error.background) == rgba(.dsError))
    #expect(rgba(DSBannerStyle.error.foreground) == rgba(.dsOnError))
    #expect(rgba(DSBannerStyle.info.background) == rgba(.dsPrimaryContainer))
    #expect(rgba(DSBannerStyle.info.foreground) == rgba(.dsOnPrimaryContainer))
    let backgrounds = DSBannerStyle.allCases.map { rgba($0.background) }
    #expect(Set(backgrounds).count == backgrounds.count)
  }

  @Test func `banner colors follow a custom theme`() {
    let theme = DSTheme(colors: .uniform(.green, primary: .red))
    #expect(rgba(DSBannerStyle.info.background, theme: theme) == rgba(.green, theme: theme))
    #expect(rgba(DSBannerStyle.error.background, theme: theme) == rgba(.green, theme: theme))
  }

  @Test func `app update keeps its values`() throws {
    let url = try #require(URL(string: "https://apps.apple.com"))
    let forced = DSAppUpdate(force: true, url: url)
    #expect(forced.force)
    #expect(forced.url == url)
    #expect(!DSAppUpdate(force: false, url: url).force)
  }

  @Test func `system symbols compare and hash by name`() {
    #expect(DSSystemSymbol.testStar == DSSystemSymbol.testStar)
    #expect(DSSystemSymbol.testStar != DSSystemSymbol.testMoon)
    #expect(DSSystemSymbol.testStar.rawValue == "star")
    #expect(Set([DSSystemSymbol.testStar, DSSystemSymbol.testStar]).count == 1)
  }

  @Test func `update texts keep every resource`() {
    let texts = DSUpdateAppTexts(
      title: "title",
      message: "message",
      updateButtonTitle: "update",
      dismissButtonTitle: "dismiss"
    )
    #expect(String(localized: texts.title) == "title")
    #expect(String(localized: texts.message) == "message")
    #expect(String(localized: texts.updateButtonTitle) == "update")
    #expect(String(localized: texts.dismissButtonTitle) == "dismiss")
  }
}
