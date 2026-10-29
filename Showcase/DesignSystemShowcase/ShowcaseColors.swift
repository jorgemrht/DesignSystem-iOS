import JDesignSystem
import SwiftUI

struct ColorsShowcase: View {
  private let tokens: [(String, Color)] = [
    ("primary", .dsPrimary),
    ("onPrimary", .dsOnPrimary),
    ("primaryContainer", .dsPrimaryContainer),
    ("onPrimaryContainer", .dsOnPrimaryContainer),
    ("inversePrimary", .dsInversePrimary),
    ("secondary", .dsSecondary),
    ("onSecondary", .dsOnSecondary),
    ("secondaryContainer", .dsSecondaryContainer),
    ("onSecondaryContainer", .dsOnSecondaryContainer),
    ("tertiary", .dsTertiary),
    ("onTertiary", .dsOnTertiary),
    ("tertiaryContainer", .dsTertiaryContainer),
    ("onTertiaryContainer", .dsOnTertiaryContainer),
    ("background", .dsBackground),
    ("onBackground", .dsOnBackground),
    ("surface", .dsSurface),
    ("onSurface", .dsOnSurface),
    ("surfaceVariant", .dsSurfaceVariant),
    ("onSurfaceVariant", .dsOnSurfaceVariant),
    ("surfaceTint", .dsSurfaceTint),
    ("inverseSurface", .dsInverseSurface),
    ("inverseOnSurface", .dsInverseOnSurface),
    ("error", .dsError),
    ("onError", .dsOnError),
    ("errorContainer", .dsErrorContainer),
    ("onErrorContainer", .dsOnErrorContainer),
    ("outline", .dsOutline),
    ("outlineVariant", .dsOutlineVariant),
    ("scrim", .dsScrim)
  ]

  var body: some View {
    ShowcasePage {
      Text(verbatim: "\(tokens.count) roles")
        .font(.headline)
        .foregroundStyle(.dsOnSurfaceVariant)

      ForEach(tokens, id: \.0) { token in
        HStack(spacing: .spacingS) {
          RoundedRectangle(cornerRadius: .cornerRadiusS)
            .fill(token.1)
            .frame(width: .controlSizeM, height: .controlSizeM)
            .overlay {
              RoundedRectangle(cornerRadius: .cornerRadiusS).stroke(.dsOutlineVariant)
            }

          Text(verbatim: "ds" + token.0.prefix(1).uppercased() + token.0.dropFirst())
            .font(.body)
            .foregroundStyle(.dsOnSurface)
        }
      }
    }
  }
}
