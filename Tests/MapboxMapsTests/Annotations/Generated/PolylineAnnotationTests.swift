// swiftlint:disable all
// This file is generated
import XCTest
import Turf
@testable import MapboxMaps

final class PolylineAnnotationTests: XCTestCase {

    func testLineJoin() {
        let lineCoordinates = [ CLLocationCoordinate2DMake(0, 0), CLLocationCoordinate2DMake(10, 10) ]
        var annotation = PolylineAnnotation(line: .init(lineCoordinates))

        annotation.lineJoin =  LineJoin.testConstantValue()

        guard let featureProperties = try? XCTUnwrap(annotation.feature.properties) else {
            return
        }
        XCTAssertEqual(featureProperties["line-join"] as? String, annotation.lineJoin?.rawValue)
    }

    func testLineSortKey() {
        let lineCoordinates = [ CLLocationCoordinate2DMake(0, 0), CLLocationCoordinate2DMake(10, 10) ]
        var annotation = PolylineAnnotation(line: .init(lineCoordinates))

        annotation.lineSortKey =  Double.testConstantValue()

        guard let featureProperties = try? XCTUnwrap(annotation.feature.properties) else {
            return
        }
        XCTAssertEqual(featureProperties["line-sort-key"] as? Double, annotation.lineSortKey)
    }

    func testLineBlur() {
        let lineCoordinates = [ CLLocationCoordinate2DMake(0, 0), CLLocationCoordinate2DMake(10, 10) ]
        var annotation = PolylineAnnotation(line: .init(lineCoordinates))

        annotation.lineBlur =  Double.testConstantValue()

        guard let featureProperties = try? XCTUnwrap(annotation.feature.properties) else {
            return
        }
        XCTAssertEqual(featureProperties["line-blur"] as? Double, annotation.lineBlur)
    }

    func testLineColor() {
        let lineCoordinates = [ CLLocationCoordinate2DMake(0, 0), CLLocationCoordinate2DMake(10, 10) ]
        var annotation = PolylineAnnotation(line: .init(lineCoordinates))

        annotation.lineColor =  ColorRepresentable.testConstantValue()

        guard let featureProperties = try? XCTUnwrap(annotation.feature.properties) else {
            return
        }
        XCTAssertEqual(featureProperties["line-color"] as? String, annotation.lineColor.flatMap { try? $0.jsonString() })
    }

    func testLineGapWidth() {
        let lineCoordinates = [ CLLocationCoordinate2DMake(0, 0), CLLocationCoordinate2DMake(10, 10) ]
        var annotation = PolylineAnnotation(line: .init(lineCoordinates))

        annotation.lineGapWidth =  Double.testConstantValue()

        guard let featureProperties = try? XCTUnwrap(annotation.feature.properties) else {
            return
        }
        XCTAssertEqual(featureProperties["line-gap-width"] as? Double, annotation.lineGapWidth)
    }

    func testLineOffset() {
        let lineCoordinates = [ CLLocationCoordinate2DMake(0, 0), CLLocationCoordinate2DMake(10, 10) ]
        var annotation = PolylineAnnotation(line: .init(lineCoordinates))

        annotation.lineOffset =  Double.testConstantValue()

        guard let featureProperties = try? XCTUnwrap(annotation.feature.properties) else {
            return
        }
        XCTAssertEqual(featureProperties["line-offset"] as? Double, annotation.lineOffset)
    }

    func testLineOpacity() {
        let lineCoordinates = [ CLLocationCoordinate2DMake(0, 0), CLLocationCoordinate2DMake(10, 10) ]
        var annotation = PolylineAnnotation(line: .init(lineCoordinates))

        annotation.lineOpacity =  Double.testConstantValue()

        guard let featureProperties = try? XCTUnwrap(annotation.feature.properties) else {
            return
        }
        XCTAssertEqual(featureProperties["line-opacity"] as? Double, annotation.lineOpacity)
    }

    func testLinePattern() {
        let lineCoordinates = [ CLLocationCoordinate2DMake(0, 0), CLLocationCoordinate2DMake(10, 10) ]
        var annotation = PolylineAnnotation(line: .init(lineCoordinates))

        annotation.linePattern =  String.testConstantValue()

        guard let featureProperties = try? XCTUnwrap(annotation.feature.properties) else {
            return
        }
        XCTAssertEqual(featureProperties["line-pattern"] as? String, annotation.linePattern)
    }

    func testLineWidth() {
        let lineCoordinates = [ CLLocationCoordinate2DMake(0, 0), CLLocationCoordinate2DMake(10, 10) ]
        var annotation = PolylineAnnotation(line: .init(lineCoordinates))

        annotation.lineWidth =  Double.testConstantValue()

        guard let featureProperties = try? XCTUnwrap(annotation.feature.properties) else {
            return
        }
        XCTAssertEqual(featureProperties["line-width"] as? Double, annotation.lineWidth)
    }
}

// End of generated file
// swiftlint:enable all