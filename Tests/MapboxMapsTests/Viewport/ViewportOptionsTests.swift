import MapboxMaps
import XCTest

final class ViewportOptionsTests: XCTestCase {
    func testInitWithDefaultValues() {
        let options = ViewportOptions()

        XCTAssertTrue(options.transitionsToIdleUponUserInteraction)
    }

    func testInitWithNonDefaultValues() {
        let transitionsToIdleUponUserInteraction = Bool.testConstantValue()

        let options = ViewportOptions(
            transitionsToIdleUponUserInteraction: transitionsToIdleUponUserInteraction)

        XCTAssertEqual(options.transitionsToIdleUponUserInteraction, transitionsToIdleUponUserInteraction)
    }
}
