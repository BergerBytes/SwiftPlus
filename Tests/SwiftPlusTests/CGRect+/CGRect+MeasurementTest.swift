import XCTest

final class CGRectMeasurementTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testExample() throws {
        let rect = CGRect(origin: .zero, size: .init(width: 2, height: 4))
        XCTAssertEqual(4.47213595499958, rect.diagonal)
        XCTAssertEqual(hypot(2, 4), rect.diagonal)
    }
}
