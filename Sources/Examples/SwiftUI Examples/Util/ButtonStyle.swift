import SwiftUI
import MapboxMaps

struct MapFloatingButtonStyle: ButtonStyle {
    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        let opacity = configuration.isPressed ? 0.8 : 1
        configuration.label
            .frame(width: 40, height: 40)
            .floating(Circle())
            .animation(.easeIn, value: opacity)
            .opacity(opacity)
    }
}

struct FloatingStyle <S: Shape>: ViewModifier {
    var padding: CGFloat
    var shape: S
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .regularMaterialBackground()
            .clipShape(shape)
            .shadow(radius: 1.4, y: 0.7)
            .padding(5)
    }
}

extension View {
    @ViewBuilder
    func regularMaterialBackground() -> some View {
        self.background(.regularMaterial)
    }
}

extension View {
    func floating<S>(padding: CGFloat = 5, _ shape: S) -> some View where S: Shape {
        modifier(FloatingStyle(padding: padding, shape: shape))
    }

    func floating(padding: CGFloat = 5) -> some View {
        floating(padding: padding, RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
    }
}

struct MapStyleSelectorButton: View {
    @Binding var mapStyle: MapStyle
    var styles: [(String, MapStyle)] = [
        ("Standard (day)", .standard(lightPreset: .day)),
        ("Standard (dusk)", .standard(lightPreset: .dusk)),
        ("Standard Satellite", .standardSatellite(lightPreset: .day)),
        ("Streets", .streets),
        ("Outdoors", .outdoors),
        ("Dark", .dark),
        ("Light", .light),
        ("Satellite Streets", .satelliteStreets),
        ("Custom", MapStyle(uri: .customStyle)),
    ]
    var body: some View {
        Menu {
            ForEach(styles, id: \.0) { style in
                Button(style.0) {
                    mapStyle = style.1
                }
            }
        } label: {
            Image(systemName: "square.2.layers.3d")
                .frame(width: 40, height: 40)
                .floating(Circle())
        }
#if !swift(>=5.9) || !os(visionOS)
        .menuOrder(.fixed)
#endif
    }
}
