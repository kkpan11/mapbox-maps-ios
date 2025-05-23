// This file is generated

/// Displays a group of ``CircleAnnotation``s.
///
/// When multiple annotation grouped, they render by a single layer. This makes annotations more performant and
/// allows to modify group-specific parameters.  For example, you can define layer slot with ``slot(_:)``.
///
/// - Note: `CircleAnnotationGroup` is a SwiftUI analog to ``CircleAnnotationManager``.
///
/// The group can be created with dynamic data, or static data. When first method is used, you specify array of identified data and provide a closure that creates a ``CircleAnnotation`` from that data, similar to ``ForEvery``:
///
/// ```swift
/// Map {
///     CircleAnnotationGroup(pivots) { pivot in
///         CircleAnnotation(centerCoordinate: pivot.coordinate)
///             .circleColor("white")
///             .circleRadius(10)
///     }
/// }
/// .slot(.top)
/// ```
///
/// When the number of annotations is static, you use static that groups one or more annotations:
///
/// ```swift
/// Map {
///     CircleAnnotationGroup {
///         CircleAnnotation(centerCoordinate: route.startCoordinate)
///             .circleColor("white")
///             .circleRadius(10)
///         CircleAnnotation(centerCoordinate: route.endCoordinate)
///             .circleColor("gray")
///             .circleRadius(10)
///     }
///     .slot(.top)
/// }
/// ```
import UIKit

public struct CircleAnnotationGroup<Data: RandomAccessCollection, ID: Hashable> {
    let annotations: [(ID, CircleAnnotation)]

    /// Creates a group that identifies data by given key path.
    ///
    /// - Parameters:
    ///     - data: Collection of data.
    ///     - id: Data identifier key path.
    ///     - content: A closure that creates annotation for a given data item.
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, content: @escaping (Data.Element) -> CircleAnnotation) {
        annotations = data.map { element in
            (element[keyPath: id], content(element))
        }
    }

    /// Creates a group from identifiable data.
    ///
    /// - Parameters:
    ///     - data: Collection of identifiable data.
    ///     - content: A closure that creates annotation for a given data item.
    public init(_ data: Data, content: @escaping (Data.Element) -> CircleAnnotation) where Data.Element: Identifiable, Data.Element.ID == ID {
        self.init(data, id: \.id, content: content)
    }

    /// Creates static group.
    ///
    /// - Parameters:
    ///     - content: A builder closure that creates annotations.
    public init(@ArrayBuilder<CircleAnnotation> content: @escaping () -> [CircleAnnotation?])
        where Data == [(Int, CircleAnnotation)], ID == Int {

        let annotations = content()
            .enumerated()
            .compactMap { $0.element == nil ? nil : ($0.offset, $0.element!) }
        self.init(annotations, id: \.0, content: \.1)
    }

    private func updateProperties(manager: CircleAnnotationManager) {
        assign(manager, \.circleElevationReference, value: circleElevationReference)
        assign(manager, \.circleSortKey, value: circleSortKey)
        assign(manager, \.circleBlur, value: circleBlur)
        assign(manager, \.circleBlurTransition, value: circleBlurTransition)
        assign(manager, \.circleColor, value: circleColor)
        assign(manager, \.circleColorUseTheme, value: circleColorUseTheme)
        assign(manager, \.circleColorTransition, value: circleColorTransition)
        assign(manager, \.circleEmissiveStrength, value: circleEmissiveStrength)
        assign(manager, \.circleEmissiveStrengthTransition, value: circleEmissiveStrengthTransition)
        assign(manager, \.circleOpacity, value: circleOpacity)
        assign(manager, \.circleOpacityTransition, value: circleOpacityTransition)
        assign(manager, \.circlePitchAlignment, value: circlePitchAlignment)
        assign(manager, \.circlePitchScale, value: circlePitchScale)
        assign(manager, \.circleRadius, value: circleRadius)
        assign(manager, \.circleRadiusTransition, value: circleRadiusTransition)
        assign(manager, \.circleStrokeColor, value: circleStrokeColor)
        assign(manager, \.circleStrokeColorUseTheme, value: circleStrokeColorUseTheme)
        assign(manager, \.circleStrokeColorTransition, value: circleStrokeColorTransition)
        assign(manager, \.circleStrokeOpacity, value: circleStrokeOpacity)
        assign(manager, \.circleStrokeOpacityTransition, value: circleStrokeOpacityTransition)
        assign(manager, \.circleStrokeWidth, value: circleStrokeWidth)
        assign(manager, \.circleStrokeWidthTransition, value: circleStrokeWidthTransition)
        assign(manager, \.circleTranslate, value: circleTranslate)
        assign(manager, \.circleTranslateTransition, value: circleTranslateTransition)
        assign(manager, \.circleTranslateAnchor, value: circleTranslateAnchor)
        assign(manager, \.slot, value: slot)
        manager.tapRadius = tapRadius
        manager.longPressRadius = longPressRadius
    }

    // MARK: - Common layer properties

    private var circleElevationReference: CircleElevationReference?
    /// Selects the base of circle-elevation. Some modes might require precomputed elevation data in the tileset.
    /// Default value: "none".
    @_documentation(visibility: public)
    @_spi(Experimental)
    public func circleElevationReference(_ newValue: CircleElevationReference) -> Self {
        with(self, setter(\.circleElevationReference, newValue))
    }

    private var circleSortKey: Double?
    /// Sorts features in ascending order based on this value. Features with a higher sort key will appear above features with a lower sort key.
    public func circleSortKey(_ newValue: Double) -> Self {
        with(self, setter(\.circleSortKey, newValue))
    }

    private var circleBlurTransition: StyleTransition?
    /// Transition property for `circleBlur`
    public func circleBlurTransition(_ transition: StyleTransition) -> Self {
        with(self, setter(\.circleBlurTransition, transition))
    }

    private var circleBlur: Double?
    /// Amount to blur the circle. 1 blurs the circle such that only the centerpoint is full opacity. Setting a negative value renders the blur as an inner glow effect.
    /// Default value: 0.
    public func circleBlur(_ newValue: Double) -> Self {
        with(self, setter(\.circleBlur, newValue))
    }

    /// The fill color of the circle.
    /// Default value: "#000000".
    public func circleColor(_ color: UIColor) -> Self {
        with(self, setter(\.circleColor, StyleColor(color)))
    }

    private var circleColorUseTheme: ColorUseTheme?
    /// This property defines whether the `circleColor` uses colorTheme from the style or not.
    /// By default it will use color defined by the root theme in the style.
    @_documentation(visibility: public)
    @_spi(Experimental)
    public func circleColorUseTheme(_ useTheme: ColorUseTheme) -> Self {
        with(self, setter(\.circleColorUseTheme, useTheme))
    }

    private var circleColorTransition: StyleTransition?
    /// Transition property for `circleColor`
    public func circleColorTransition(_ transition: StyleTransition) -> Self {
        with(self, setter(\.circleColorTransition, transition))
    }

    private var circleColor: StyleColor?
    /// The fill color of the circle.
    /// Default value: "#000000".
    public func circleColor(_ newValue: StyleColor) -> Self {
        with(self, setter(\.circleColor, newValue))
    }

    private var circleEmissiveStrengthTransition: StyleTransition?
    /// Transition property for `circleEmissiveStrength`
    public func circleEmissiveStrengthTransition(_ transition: StyleTransition) -> Self {
        with(self, setter(\.circleEmissiveStrengthTransition, transition))
    }

    private var circleEmissiveStrength: Double?
    /// Controls the intensity of light emitted on the source features.
    /// Default value: 0. Minimum value: 0. The unit of circleEmissiveStrength is in intensity.
    public func circleEmissiveStrength(_ newValue: Double) -> Self {
        with(self, setter(\.circleEmissiveStrength, newValue))
    }

    private var circleOpacityTransition: StyleTransition?
    /// Transition property for `circleOpacity`
    public func circleOpacityTransition(_ transition: StyleTransition) -> Self {
        with(self, setter(\.circleOpacityTransition, transition))
    }

    private var circleOpacity: Double?
    /// The opacity at which the circle will be drawn.
    /// Default value: 1. Value range: [0, 1]
    public func circleOpacity(_ newValue: Double) -> Self {
        with(self, setter(\.circleOpacity, newValue))
    }

    private var circlePitchAlignment: CirclePitchAlignment?
    /// Orientation of circle when map is pitched.
    /// Default value: "viewport".
    public func circlePitchAlignment(_ newValue: CirclePitchAlignment) -> Self {
        with(self, setter(\.circlePitchAlignment, newValue))
    }

    private var circlePitchScale: CirclePitchScale?
    /// Controls the scaling behavior of the circle when the map is pitched.
    /// Default value: "map".
    public func circlePitchScale(_ newValue: CirclePitchScale) -> Self {
        with(self, setter(\.circlePitchScale, newValue))
    }

    private var circleRadiusTransition: StyleTransition?
    /// Transition property for `circleRadius`
    public func circleRadiusTransition(_ transition: StyleTransition) -> Self {
        with(self, setter(\.circleRadiusTransition, transition))
    }

    private var circleRadius: Double?
    /// Circle radius.
    /// Default value: 5. Minimum value: 0. The unit of circleRadius is in pixels.
    public func circleRadius(_ newValue: Double) -> Self {
        with(self, setter(\.circleRadius, newValue))
    }

    /// The stroke color of the circle.
    /// Default value: "#000000".
    public func circleStrokeColor(_ color: UIColor) -> Self {
        with(self, setter(\.circleStrokeColor, StyleColor(color)))
    }

    private var circleStrokeColorUseTheme: ColorUseTheme?
    /// This property defines whether the `circleStrokeColor` uses colorTheme from the style or not.
    /// By default it will use color defined by the root theme in the style.
    @_documentation(visibility: public)
    @_spi(Experimental)
    public func circleStrokeColorUseTheme(_ useTheme: ColorUseTheme) -> Self {
        with(self, setter(\.circleStrokeColorUseTheme, useTheme))
    }

    private var circleStrokeColorTransition: StyleTransition?
    /// Transition property for `circleStrokeColor`
    public func circleStrokeColorTransition(_ transition: StyleTransition) -> Self {
        with(self, setter(\.circleStrokeColorTransition, transition))
    }

    private var circleStrokeColor: StyleColor?
    /// The stroke color of the circle.
    /// Default value: "#000000".
    public func circleStrokeColor(_ newValue: StyleColor) -> Self {
        with(self, setter(\.circleStrokeColor, newValue))
    }

    private var circleStrokeOpacityTransition: StyleTransition?
    /// Transition property for `circleStrokeOpacity`
    public func circleStrokeOpacityTransition(_ transition: StyleTransition) -> Self {
        with(self, setter(\.circleStrokeOpacityTransition, transition))
    }

    private var circleStrokeOpacity: Double?
    /// The opacity of the circle's stroke.
    /// Default value: 1. Value range: [0, 1]
    public func circleStrokeOpacity(_ newValue: Double) -> Self {
        with(self, setter(\.circleStrokeOpacity, newValue))
    }

    private var circleStrokeWidthTransition: StyleTransition?
    /// Transition property for `circleStrokeWidth`
    public func circleStrokeWidthTransition(_ transition: StyleTransition) -> Self {
        with(self, setter(\.circleStrokeWidthTransition, transition))
    }

    private var circleStrokeWidth: Double?
    /// The width of the circle's stroke. Strokes are placed outside of the `circle-radius`.
    /// Default value: 0. Minimum value: 0. The unit of circleStrokeWidth is in pixels.
    public func circleStrokeWidth(_ newValue: Double) -> Self {
        with(self, setter(\.circleStrokeWidth, newValue))
    }

    private var circleTranslateTransition: StyleTransition?
    /// Transition property for `circleTranslate`
    public func circleTranslateTransition(_ transition: StyleTransition) -> Self {
        with(self, setter(\.circleTranslateTransition, transition))
    }

    private var circleTranslate: [Double]?
    /// The geometry's offset. Values are [x, y] where negatives indicate left and up, respectively.
    /// Default value: [0,0]. The unit of circleTranslate is in pixels.
    public func circleTranslate(x: Double, y: Double) -> Self {
        with(self, setter(\.circleTranslate, [x, y]))
    }

    private var circleTranslateAnchor: CircleTranslateAnchor?
    /// Controls the frame of reference for `circle-translate`.
    /// Default value: "map".
    public func circleTranslateAnchor(_ newValue: CircleTranslateAnchor) -> Self {
        with(self, setter(\.circleTranslateAnchor, newValue))
    }

    private var slot: String?
    /// Slot for the underlying layer.
    ///
    /// Use this property to position the annotations relative to other map features if you use Mapbox Standard Style.
    /// See <doc:Migrate-to-v11##21-The-Mapbox-Standard-Style> for more info.
    @available(*, deprecated, message: "Use Slot type instead of string")
    public func slot(_ newValue: String) -> Self {
        with(self, setter(\.slot, newValue))
    }

    /// Slot for the underlying layer.
    ///
    /// Use this property to position the annotations relative to other map features if you use Mapbox Standard Style.
    /// See <doc:Migrate-to-v11##21-The-Mapbox-Standard-Style> for more info.
    public func slot(_ newValue: Slot?) -> Self {
        with(self, setter(\.slot, newValue?.rawValue))
    }

    private var layerId: String?

    /// Specifies identifier for underlying implementation layer.
    ///
    /// Use the identifier to create view annotations bound the annotations from the group.
    /// For more information, see the ``MapViewAnnotation/init(layerId:featureId:content:)``.
    public func layerId(_ layerId: String) -> Self {
        with(self, setter(\.layerId, layerId))
    }

    var tapRadius: CGFloat?
    var longPressRadius: CGFloat?

    /// A custom tappable area radius. Default value is 0.
    public func tapRadius(_ radius: CGFloat? = nil) -> Self {
        with(self, setter(\.tapRadius, radius))
    }

    /// A custom tappable area radius. Default value is 0.
    public func longPressRadius(_ radius: CGFloat? = nil) -> Self {
        with(self, setter(\.longPressRadius, radius))
    }
}

extension CircleAnnotationGroup: MapContent, PrimitiveMapContent {
    func visit(_ node: MapContentNode) {
        let group = MountedAnnotationGroup(
            layerId: layerId ?? node.id.stringId,
            clusterOptions: nil,
            annotations: annotations,
            updateProperties: updateProperties
        )
        node.mount(group)
    }
}

// End of generated file.
