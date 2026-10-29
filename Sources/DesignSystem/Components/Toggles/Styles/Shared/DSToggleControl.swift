import SwiftUI

struct DSToggleControlState {
  let isOn: Bool
  let isPressed: Bool
  let isEnabled: Bool
  let appearance: DSToggleAppearance
  let scale: CGFloat

  var track: Color {
    appearance.trackColor(isOn: isOn, isEnabled: isEnabled)
  }

  var thumb: Color {
    appearance.thumbColor(isOn: isOn, isEnabled: isEnabled)
  }

  var outline: Color {
    appearance.outlineColor(isOn: isOn, isEnabled: isEnabled)
  }
}

struct DSSwitchMetrics: Equatable {
  let scale: CGFloat

  var trackHeight: CGFloat {
    32 * scale
  }

  var trackWidth: CGFloat {
    52 * scale
  }

  func thumbDiameter(isOn: Bool, isPressed: Bool) -> CGFloat {
    switch (isPressed, isOn) {
    case (true, _): 28 * scale
    case (false, true): 24 * scale
    case (false, false): 16 * scale
    }
  }

  func thumbInset(isOn: Bool, isPressed: Bool) -> CGFloat {
    (trackHeight - thumbDiameter(isOn: isOn, isPressed: isPressed)) / 2
  }
}

struct DSSwitchControl: View {
  let state: DSToggleControlState

  var body: some View {
    let metrics = DSSwitchMetrics(scale: state.scale)
    let diameter = metrics.thumbDiameter(isOn: state.isOn, isPressed: state.isPressed)

    Capsule()
      .fill(state.track)
      .overlay {
        Capsule().strokeBorder(state.outline, lineWidth: 2)
      }
      .frame(width: metrics.trackWidth, height: metrics.trackHeight)
      .overlay(alignment: state.isOn ? .trailing : .leading) {
        Circle()
          .fill(state.thumb)
          .frame(width: diameter, height: diameter)
          .padding(.horizontal, metrics.thumbInset(isOn: state.isOn, isPressed: state.isPressed))
      }
      .accessibilityHidden(true)
  }
}

struct DSCheckboxControl: View {
  let state: DSToggleControlState

  var body: some View {
    let side = CGFloat.iconSizeM * state.scale

    RoundedRectangle(cornerRadius: .cornerRadiusXS)
      .fill(state.isOn ? state.track : .clear)
      .overlay {
        RoundedRectangle(cornerRadius: .cornerRadiusXS).strokeBorder(state.outline, lineWidth: 2)
      }
      .overlay {
        DSCheckmark()
          .trim(from: 0, to: state.isOn ? 1 : 0)
          .stroke(state.thumb, style: StrokeStyle(lineWidth: 2 * state.scale, lineCap: .round, lineJoin: .round))
          .padding(side * 0.22)
      }
      .frame(width: side, height: side)
      .accessibilityHidden(true)
  }
}

struct DSCheckmark: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.minX, y: rect.minY + rect.height * 0.55))
    path.addLine(to: CGPoint(x: rect.minX + rect.width * 0.38, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
    return path
  }
}
