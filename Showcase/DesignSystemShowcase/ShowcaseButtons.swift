import JDesignSystem
import SwiftUI

struct ButtonsShowcase: View {
  var body: some View {
    ShowcasePage {
      ShowcaseGroup(title: "Hierarchies") {
        Button("Primary") {}.buttonStyle(.dsPrimary)
        Button("Secondary") {}.buttonStyle(.dsSecondary)
        Button("Bordered") {}.buttonStyle(.dsBordered)
        Button("Tertiary") {}.buttonStyle(.dsTertiary)
      }

      ShowcaseGroup(title: "Destructive role") {
        Button("Delete", role: .destructive) {}.buttonStyle(.dsPrimary)
        Button("Delete", role: .destructive) {}.buttonStyle(.dsSecondary)
        Button("Delete", role: .destructive) {}.buttonStyle(.dsBordered)
        Button("Delete", role: .destructive) {}.buttonStyle(.dsTertiary)
      }

      ShowcaseGroup(title: "Corner style") {
        Button("Capsule") {}.buttonStyle(.dsPrimary)
        Button("Fixed") {}.buttonStyle(.dsPrimary(cornerStyle: .fixed(.cornerRadiusM)))
        VStack {
          Button("Concentric") {}
            .buttonStyle(.dsPrimary(cornerStyle: .concentric(minimum: .cornerRadiusS)))
            .buttonSizing(.flexible)
        }
        .padding(.spacingXS)
        .background(.dsSurface, in: .rect(cornerRadius: .cornerRadiusXL))
        .containerShape(.rect(cornerRadius: .cornerRadiusXL))
      }

      ShowcaseGroup(title: "Sizes") {
        Button("Small") {}.buttonStyle(.dsPrimary(size: .small))
        Button("Medium") {}.buttonStyle(.dsPrimary(size: .medium))
        Button("Large") {}.buttonStyle(.dsPrimary(size: .large))
      }

      ShowcaseGroup(title: "Full width") {
        Button("Continue") {}.buttonStyle(.dsPrimary)
          .buttonSizing(.flexible)
        Button("With icon", systemSymbol: .checkmark) {}.buttonStyle(.dsBordered)
          .buttonSizing(.flexible)
      }

      ShowcaseGroup(title: "Disabled") {
        Button("Primary") {}.buttonStyle(.dsPrimary).disabled(true)
        Button("Bordered") {}.buttonStyle(.dsBordered).disabled(true)
        Button("Tertiary") {}.buttonStyle(.dsTertiary).disabled(true)
      }
    }
  }
}

struct IconAndFABShowcase: View {
  var body: some View {
    ShowcasePage {
      ShowcaseGroup(title: "Icon button") {
        HStack(spacing: .spacingS) {
          DSIconButton("Search", systemSymbol: .search) {}
          DSIconButton("Search", systemSymbol: .search, prominence: .bordered) {}
          DSIconButton("Search", systemSymbol: .search, prominence: .primary) {}
          DSIconButton("Search", systemSymbol: .search, isEnabled: false) {}
        }
      }

      ShowcaseGroup(title: "Icon button · sizes") {
        HStack(spacing: .spacingS) {
          DSIconButton("Close", systemSymbol: .close, prominence: .bordered, size: .small) {}
          DSIconButton("Close", systemSymbol: .close, prominence: .bordered, size: .medium) {}
          DSIconButton("Close", systemSymbol: .close, prominence: .bordered, size: .large) {}
        }
      }

      ShowcaseGroup(title: "FAB") {
        HStack(spacing: .spacingS) {
          Button("Add", systemSymbol: .add) {}.buttonStyle(.dsFAB)
          Button("Add", systemSymbol: .add) {}.buttonStyle(.dsFAB(variant: .secondaryContainer))
          Button("Add", systemSymbol: .add) {}.buttonStyle(.dsFAB(variant: .tertiaryContainer))
          Button("Add", systemSymbol: .add) {}.buttonStyle(.dsFAB).disabled(true)
        }
      }

      ShowcaseGroup(title: "FAB · sizes") {
        HStack(spacing: .spacingS) {
          Button("Add", systemSymbol: .add) {}.buttonStyle(.dsFAB(size: .small))
          Button("Add", systemSymbol: .add) {}.buttonStyle(.dsFAB(size: .medium))
          Button("Add", systemSymbol: .add) {}.buttonStyle(.dsFAB(size: .large))
        }
      }
    }
  }
}

struct GlassShowcase: View {
  var body: some View {
    ShowcasePage {
      #if os(visionOS)
      Text(verbatim: "Glass is not available on this platform")
      #else
      ShowcaseGroup(title: "Glass icon") {
        HStack(spacing: .spacingM) {
          Button("Search", systemSymbol: .search) {}.buttonStyle(.dsGlassIcon)
          Button("Search", systemSymbol: .search) {}.buttonStyle(.dsGlassIcon(prominence: .bordered))
          Button("Search", systemSymbol: .search) {}.buttonStyle(.dsGlassIcon(prominence: .primary))
        }
      }

      ShowcaseGroup(title: "Glass FAB") {
        HStack(spacing: .spacingM) {
          Button("Add", systemSymbol: .add) {}.buttonStyle(.dsGlassFAB)
          Button("Add", systemSymbol: .add) {}.buttonStyle(.dsGlassFAB(variant: .secondaryContainer))
          Button("Add", systemSymbol: .add) {}.buttonStyle(.dsGlassFAB(variant: .tertiaryContainer))
        }
      }
      #endif
    }
    .background {
      LinearGradient(
        colors: [.dsPrimaryContainer, .dsTertiaryContainer],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
      )
    }
  }
}
