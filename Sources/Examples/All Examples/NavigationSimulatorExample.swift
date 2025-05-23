import UIKit
@_spi(Experimental) import MapboxMaps

final class NavigationSimulatorExample: UIViewController, ExampleProtocol {
    private var mapView: MapView!
    private var navigationSimulator: NavigationSimulator!
    private var cancelables = Set<AnyCancelable>()

    private lazy var routeSource: Source = {
        var source = GeoJSONSource(id: ID.routeSource)
        source.data = .geometry(Geometry(sampleRouteLine))
        source.lineMetrics = true

        return source
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MapView(frame: view.bounds)
        configureMap()

        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        // The below line is used for internal testing purposes only.
        finish()
    }

    private func configureMap() {
        navigationSimulator = NavigationSimulator(viewport: mapView.viewport, route: sampleRouteLine)

        let configuration = Puck2DConfiguration(topImage: UIImage(named: "dash-puck")!)
        mapView.location.options.puckType = .puck2D(configuration)
        mapView.location.options.puckBearing = .course
        mapView.location.options.puckBearingEnabled = true
        mapView.location.override(locationProvider: navigationSimulator)
        mapView.location.onPuckRender.observe { [weak self] in
            self?.onPuckRender(data: $0)
        }.store(in: &cancelables)

        do {
            try mapView.mapboxMap.addSource(routeSource)
            try mapView.mapboxMap.addPersistentLayer(makeCasingLayer())
            try mapView.mapboxMap.addPersistentLayer(makeRouteLineLayer())

            navigationSimulator.start()
        } catch {
            print("Unexpected error when adding source/style: \(error)")
        }
    }

    // MARK: - Util

    private func makeRouteLineLayer() -> LineLayer {
        var routeLayer = LineLayer(id: ID.routeLineLayer, source: ID.routeSource)
        routeLayer.lineCap = .constant(.round)
        routeLayer.lineJoin = .constant(.round)
        routeLayer.lineTrimColor = .constant(StyleColor(.lightGray))
        routeLayer.lineTrimFadeRange = .constant([0.0, 0.0001])
        routeLayer.lineWidth = .expression(
            Exp(.interpolate) {
                Exp(.exponential) {
                    1.5
                }
                Exp(.zoom)
                4.0
                Exp(.product) {
                    3.0
                    1.0
                }
                10.0
                Exp(.product) {
                    4.0
                    1.0
                }
                13.0
                Exp(.product) {
                    6.0
                    1.0
                }
                16.0
                Exp(.product) {
                    10.0
                    1.0
                }
                19.0
                Exp(.product) {
                    14.0
                    1.0
                }
                22.0
                Exp(.product) {
                    18.0
                    1.0
                }
            }
        )
        routeLayer.lineGradient = .expression(
            Exp(.interpolate) {
                Exp(.linear)
                Exp(.lineProgress)
                0.0
                UIColor(red: 6.0/255.0, green: 1.0/255.0, blue: 255.0/255.0, alpha: 1)
                0.1
                UIColor(red: 59.0/255.0, green: 118.0/255.0, blue: 227.0/255.0, alpha: 1)
                0.3
                UIColor(red: 7.0/255.0, green: 238.0/255.0, blue: 251.0/255.0, alpha: 1)
                0.5
                UIColor(red: 0, green: 255.0/255.0, blue: 42.0/255.0, alpha: 1)
                0.7
                UIColor(red: 255.0/255.0, green: 252.0/255.0, blue: 0, alpha: 1)
                1.0
                UIColor(red: 255.0/255.0, green: 30.0/255.0, blue: 0, alpha: 1)
            }
        )

        return routeLayer
    }

    private func makeCasingLayer() -> LineLayer {
        var casingLayer = LineLayer(id: ID.casingLineLayer, source: ID.routeSource)
        casingLayer.lineCap = .constant(.round)
        casingLayer.lineJoin = .constant(.round)

        casingLayer.lineWidth = .expression(
            Exp(.interpolate) {
                Exp(.exponential) {
                    1.5
                }
                Exp(.zoom)
                10.0
                Exp(.product) {
                    7.0
                    1.0
                }
                14.0
                Exp(.product) {
                    10.5
                    1.0
                }
                16.5
                Exp(.product) {
                    15.5
                    1.0
                }
                19.0
                Exp(.product) {
                    24.0
                    1.0
                }
                22.0
                Exp(.product) {
                    29.0
                    1.0
                }
            }
        )
        casingLayer.lineGradient = .expression(
            Exp(.interpolate) {
                Exp(.linear)
                Exp(.lineProgress)
                0.0
                UIColor(red: 47.0/255.0, green: 122.0/255.0, blue: 198.0/255.0, alpha: 1)
                1.0
                UIColor(red: 47.0/255.0, green: 122.0/255.0, blue: 198.0/255.0, alpha: 1)
            }
        )

        return casingLayer
    }

    // MARK: Sample Data

    private lazy var sampleRouteLine: LineString = {
        do {
            enum Error: Swift.Error {
                case invalidGeoJSON
            }
            return try Bundle.main.url(forResource: "route", withExtension: "geojson")
                .map { url in try Data(contentsOf: url) }
                .map { data in
                    let feature = try JSONDecoder().decode(Feature.self, from: data)
                    switch feature.geometry {
                    case .lineString(let lineString): return lineString
                    default: throw Error.invalidGeoJSON
                    }
                }!
        } catch {
            fatalError("Unable to decode Route GeoJSON source")
        }
    }()

    private func onPuckRender(data: PuckRenderingData) {
        let progress = navigationSimulator.progressFromStart(to: data.location)

        try? mapView.mapboxMap.setLayerProperty(for: ID.routeLineLayer, property: "line-trim-offset", value: [0, progress])
        try? mapView.mapboxMap.setLayerProperty(for: ID.casingLineLayer, property: "line-trim-offset", value: [0, progress])
    }
}

extension NavigationSimulatorExample {
    private enum ID {
        static let routeSource = "route-line-source-id"
        static let routeLineLayer = "route-line-layer-id"
        static let casingLineLayer = "route-casing-layer-id"
    }
}
