@testable import SwiftPlus
import XCTest

final class CollectionSafeSubscriptTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_index_exists() throws {
        let array = [0, 1, 2, 3]
        XCTAssertNotNil(array[safe: 0])
        XCTAssertNotNil(array[safe: 1])
        XCTAssertNotNil(array[safe: 2])
        XCTAssertNotNil(array[safe: 3])
    }

    func test_index_doesNot_exist() throws {
        let array = [0, 1, 2, 3]
        XCTAssertNil(array[safe: -1])
        XCTAssertNil(array[safe: 4])
        XCTAssertNil(array[safe: 5])
    }
}
