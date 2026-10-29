import JDesignSystem
import SwiftUI

struct ShowcaseRootView: View {
  @Binding var appearance: ShowcaseAppearance

  var body: some View {
    NavigationStack {
      List {
        Section {
          Picker("Appearance", selection: $appearance) {
            ForEach(ShowcaseAppearance.allCases) { appearance in
              Text(verbatim: appearance.rawValue).tag(appearance)
            }
          }
          .showcaseSegmentedPicker()
        }

        Section("Components") {
          ForEach(ShowcaseSection.allCases) { section in
            NavigationLink(value: section) {
              Text(verbatim: section.title)
            }
          }
        }
      }
      .dsListBackgroundColor(.dsBackground)
      .navigationTitle(Text(verbatim: "JDesignSystem"))
      .navigationDestination(for: ShowcaseSection.self) { section in
        section.destination
          .navigationTitle(Text(verbatim: section.title))
      }
    }
  }
}

enum ShowcaseSection: CaseIterable, Identifiable, Hashable {
  case colors
  case buttons
  case iconAndFAB
  case glass
  case textFields
  case textArea
  case toggles
  case cards
  case cornerStyle
  case screenScroll
  case skeleton
  case labels
  case dividers
  case loadMore
  case banners
  case loading
  case progress
  case appUpdate
  case remoteImage

  var id: Self {
    self
  }

  var title: String {
    switch self {
    case .colors: "Colors"
    case .buttons: "Buttons"
    case .iconAndFAB: "Icon & FAB"
    case .glass: "Glass"
    case .textFields: "Text fields"
    case .textArea: "Text area"
    case .toggles: "Toggles"
    case .cards: "Cards"
    case .cornerStyle: "Corner style"
    case .screenScroll: "Screen scroll"
    case .skeleton: "Skeleton"
    case .labels: "Labels"
    case .dividers: "Dividers"
    case .loadMore: "Load more"
    case .banners: "Banners"
    case .loading: "Loading"
    case .progress: "Progress"
    case .appUpdate: "App update"
    case .remoteImage: "Remote image"
    }
  }

  @ViewBuilder
  var destination: some View {
    switch self {
    case .colors: ColorsShowcase()
    case .buttons: ButtonsShowcase()
    case .iconAndFAB: IconAndFABShowcase()
    case .glass: GlassShowcase()
    case .textFields: TextFieldsShowcase()
    case .textArea: TextAreaShowcase()
    case .toggles: TogglesShowcase()
    case .cards: CardsShowcase()
    case .cornerStyle: CornerStyleShowcase()
    case .screenScroll: ScreenScrollShowcase()
    case .skeleton: SkeletonShowcase()
    case .labels: LabelsShowcase()
    case .dividers: DividersShowcase()
    case .loadMore: LoadMoreShowcase()
    case .banners: BannersShowcase()
    case .loading: LoadingShowcase()
    case .progress: ProgressShowcase()
    case .appUpdate: AppUpdateShowcase()
    case .remoteImage: RemoteImageShowcase()
    }
  }
}

struct ShowcasePage<Content: View>: View {
  @ViewBuilder let content: Content

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: .spacingM) {
        Group(subviews: content) { subviews in
          ForEach(subviews) { subview in
            subview

            if subview.id != subviews.last?.id {
              Divider()
            }
          }
        }
      }
      .padding(.spacingS)
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .background(.dsBackground)
  }
}

struct ShowcaseGroup<Content: View>: View {
  let title: String
  @ViewBuilder let content: Content

  var body: some View {
    VStack(alignment: .leading, spacing: .spacingXXS) {
      Text(verbatim: title)
        .font(.headline)
        .foregroundStyle(.dsOnSurfaceVariant)
      content
    }
  }
}

extension View {
  func showcaseSegmentedPicker() -> some View {
    #if os(watchOS)
    pickerStyle(.automatic)
    #else
    pickerStyle(.segmented)
    #endif
  }
}
