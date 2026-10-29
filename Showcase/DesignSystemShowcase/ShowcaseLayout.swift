import JDesignSystem
import SwiftUI

struct CardsShowcase: View {
  var body: some View {
    ShowcasePage {
      ShowcaseGroup(title: "Filled") {
        card("Filled card").dsCard(.filled)
      }

      ShowcaseGroup(title: "Elevated") {
        card("Elevated card").dsCard(.elevated)
      }

      ShowcaseGroup(title: "Outlined") {
        card("Outlined card").dsCard(.outlined)
      }

      ShowcaseGroup(title: "Inherited variant") {
        VStack(spacing: .spacingS) {
          card("First card").dsCard()
          card("Second card").dsCard()
          card("Explicit outlined").dsCard(.outlined)
        }
        .dsCardVariant(.elevated)
      }

      ShowcaseGroup(title: "Concentric corners") {
        card("Concentric card")
          .dsCard(.outlined, cornerStyle: .concentric())
          .padding(.spacingS)
          .background(.dsSurfaceVariant, in: .rect(cornerRadius: .cornerRadiusXXL))
          .containerShape(.rect(cornerRadius: .cornerRadiusXXL))
      }

      ShowcaseGroup(title: "Capsule corners") {
        card("Capsule card").dsCard(.outlined, cornerStyle: .capsule)
      }
    }
  }

  private func card(_ title: String) -> some View {
    VStack(alignment: .leading, spacing: .spacingXXS) {
      Text(verbatim: title)
        .font(.headline)
      Text(verbatim: "Content clipped to the card shape.")
        .foregroundStyle(.dsOnSurfaceVariant)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct LabelsShowcase: View {
  var body: some View {
    ShowcasePage {
      ShowcaseGroup(title: "Leading icon") {
        Label { Text(verbatim: "Favorites") } icon: { Image(systemSymbol: .star) }
          .labelStyle(.dsLabel)
      }

      ShowcaseGroup(title: "Trailing icon") {
        Label { Text(verbatim: "Continue") } icon: { Image(systemSymbol: .chevron) }
          .labelStyle(.dsLabel(iconEdge: .trailing))
      }

      ShowcaseGroup(title: "Custom spacing") {
        Label { Text(verbatim: "Share") } icon: { Image(systemSymbol: .share) }
          .labelStyle(.dsLabel(iconEdge: .trailing, spacing: .spacingS))
      }
    }
  }
}

struct SkeletonShowcase: View {
  @State private var isLoading = true
  @State private var isTinted = false
  @State private var notifications = true
  @State private var terms = true
  @State private var name = "Ada Lovelace"

  var body: some View {
    VStack(alignment: .leading, spacing: .spacingM) {
      Toggle(isOn: $isLoading) { Text(verbatim: "Loading") }
        .toggleStyle(.dsSwitch)

      Toggle(isOn: $isTinted) { Text(verbatim: "Tinted skeleton") }
        .toggleStyle(.dsSwitch)

      DSDivider()

      VStack(alignment: .leading, spacing: .spacingM) {
        ForEach(Array(SkeletonItem.items(isLoading: isLoading).enumerated()), id: \.element.id) { index, item in
          row(item)
            .dsCard(SkeletonItem.variants[index % SkeletonItem.variants.count])
        }

        TextField("Name", text: $name)
          .textFieldStyle(.dsBorderedTextField(title: "Full name", message: "Shown on your profile"))

        Toggle(isOn: $notifications) { Text(verbatim: "Notifications") }
          .toggleStyle(.dsSwitch)

        Toggle(isOn: $terms) { Text(verbatim: "Accept the terms") }
          .toggleStyle(.dsCheckbox)

        ProgressView(value: 0.6) { Text(verbatim: "Uploading") } currentValueLabel: { Text(verbatim: "60%") }
          .progressViewStyle(.dsLinear)

        Label { Text(verbatim: "Continue") } icon: { Image(systemSymbol: .chevron) }
          .labelStyle(.dsLabel(iconEdge: .trailing))

        Button("Save changes") {}
          .buttonStyle(.dsPrimary)
          .buttonSizing(.flexible)

        Button("Cancel") {}
          .buttonStyle(.dsBordered)
          .buttonSizing(.flexible)
      }
      .dsSkeleton(isLoading, appearance: isTinted ? .tinted(.dsPrimaryContainer) : .standard)

      Spacer(minLength: .spacingS)
    }
    .padding(.horizontal, .spacingS)
    .dsScreenScroll()
    .background(.dsBackground)
  }

  private func row(_ item: SkeletonItem) -> some View {
    HStack(spacing: .spacingS) {
      Image(systemSymbol: .star)
        .font(.title2)
      VStack(alignment: .leading, spacing: .spacingXXS) {
        Text(verbatim: item.title)
          .font(.headline)
        Text(verbatim: item.subtitle)
          .foregroundStyle(.dsOnSurfaceVariant)
      }
      Spacer(minLength: 0)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

private struct SkeletonItem: Identifiable {
  let id: Int
  let title: String
  let subtitle: String

  static let variants: [DSCardVariant] = [.filled, .elevated, .outlined]

  static func items(isLoading: Bool) -> [Self] {
    isLoading ? placeholders : loaded
  }

  static let placeholders = (1 ... 7).map {
    Self(id: $0, title: "Placeholder title", subtitle: "Placeholder subtitle for the row")
  }

  static let loaded = [
    Self(id: 1, title: "Inbox", subtitle: "12 unread messages"),
    Self(id: 2, title: "Drafts", subtitle: "3 saved drafts"),
    Self(id: 3, title: "Sent", subtitle: "Last sent today"),
    Self(id: 4, title: "Archive", subtitle: "248 conversations"),
    Self(id: 5, title: "Starred", subtitle: "9 conversations"),
    Self(id: 6, title: "Spam", subtitle: "Nothing new"),
    Self(id: 7, title: "Trash", subtitle: "Emptied 3 days ago")
  ]
}

private extension DSSystemSymbol {
  static let star = Self("star")
  static let chevron = Self("chevron.right")
  static let share = Self("square.and.arrow.up")
}

struct DividersShowcase: View {
  var body: some View {
    ShowcasePage {
      ShowcaseGroup(title: "Horizontal") {
        Text(verbatim: "Above")
        DSDivider()
        Text(verbatim: "Below")
      }

      ShowcaseGroup(title: "Vertical") {
        HStack(spacing: .spacingS) {
          Text(verbatim: "Leading")
          DSDivider()
          Text(verbatim: "Trailing")
        }
        .fixedSize(horizontal: false, vertical: true)
      }

      ShowcaseGroup(title: "Custom color") {
        DSDivider(color: .dsPrimary)
      }
    }
  }
}

struct LoadMoreShowcase: View {
  @State private var count = 12
  @State private var isLoading = false

  private let pageSize = 8
  private let limit = 40

  var body: some View {
    List {
      ForEach(0 ..< count, id: \.self) { index in
        Text(verbatim: "Row \(index + 1)")
      }

      if count < limit {
        DSLoadMoreRow(isLoading: isLoading) {
          loadNextPage()
        }
      }
    }
    .dsListBackgroundColor(.dsBackground)
  }

  private func loadNextPage() {
    isLoading = true
    Task {
      try? await Task.sleep(for: .seconds(1))
      count = min(count + pageSize, limit)
      isLoading = false
    }
  }
}

struct CornerStyleShowcase: View {
  @State private var selection = CornerStyleOption.inherited
  @State private var text = ""
  @State private var area = ""

  var body: some View {
    ShowcasePage {
      Picker("Corner style", selection: $selection) {
        ForEach(CornerStyleOption.allCases) { option in
          Text(verbatim: option.title).tag(option)
        }
      }
      .showcaseSegmentedPicker()

      VStack(alignment: .leading, spacing: .spacingS) {
        Button("Primary") {}
          .buttonStyle(.dsPrimary)
        TextField("Name", text: $text)
          .textFieldStyle(.dsBorderedTextField(title: "Bordered"))
        #if !os(tvOS) && !os(watchOS)
        DSTextArea("Notes", text: $area)
        #endif
        Text(verbatim: "Card")
          .frame(maxWidth: .infinity, alignment: .leading)
          .dsCard(.outlined)
      }
      .dsCornerStyle(selection.style)
    }
  }
}

private enum CornerStyleOption: CaseIterable, Identifiable {
  case inherited
  case capsule
  case rounded
  case square

  var id: Self {
    self
  }

  var title: String {
    switch self {
    case .inherited: "Default"
    case .capsule: "Capsule"
    case .rounded: "Rounded"
    case .square: "Square"
    }
  }

  var style: DSCornerStyle? {
    switch self {
    case .inherited: nil
    case .capsule: .capsule
    case .rounded: .fixed(.cornerRadiusL)
    case .square: .fixed(.cornerRadiusNone)
    }
  }
}

struct ScreenScrollShowcase: View {
  @State private var rows = 2

  var body: some View {
    VStack(spacing: .spacingS) {
      HStack(spacing: .spacingS) {
        Button("Fewer") { rows = max(1, rows - 1) }
          .buttonStyle(.dsBordered)
        Button("More") { rows = min(30, rows + 1) }
          .buttonStyle(.dsBordered)
        Text(verbatim: "Rows: \(rows)")
        Spacer(minLength: 0)
      }

      ForEach(0 ..< rows, id: \.self) { index in
        Text(verbatim: "Row \(index + 1)")
          .frame(maxWidth: .infinity, alignment: .leading)
          .dsCard()
      }

      Spacer(minLength: .spacingS)

      Button("Pinned to the bottom when short") {}
        .buttonStyle(.dsPrimary)
        .buttonSizing(.flexible)
    }
    .padding(.horizontal, .spacingS)
    .dsScreenScroll()
    .background(.dsBackground)
  }
}
