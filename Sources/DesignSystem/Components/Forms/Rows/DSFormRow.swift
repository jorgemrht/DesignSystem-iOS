import SwiftUI

struct DSFormRow<Label: View, Trailing: View>: View {
  @ViewBuilder let label: Label
  @ViewBuilder let trailing: Trailing

  var body: some View {
    HStack(spacing: .spacingXS) {
      label
        .font(.body)
        .foregroundStyle(.dsOnSurface)

      Spacer(minLength: .spacingS)

      trailing
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
