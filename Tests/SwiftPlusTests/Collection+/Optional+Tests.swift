@testable import SwiftPlus
import XCTest

final class OptionalTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_isNil() {
        let foo: String? = nil
        XCTAssertTrue(foo.isNil)
        XCTAssertFalse(foo.isNotNil)
    }

    func test_isNotNil() {
        let foo: String? = "bar"
        XCTAssertFalse(foo.isNil)
        XCTAssertTrue(foo.isNotNil)
    }
}
