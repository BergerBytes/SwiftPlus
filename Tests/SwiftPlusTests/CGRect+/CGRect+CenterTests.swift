import XCTest

final class CGRectCenterTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_init_center() throws {
        let rect = CGRect(center: .init(x: 1, y: 1), size: .init(width: 1, height: 1))
        XCTAssertEqual(CGRect(origin: .init(x: 0.5, y: 0.5), size: .init(width: 1, height: 1)), rect)
    }

    func test_center_getter() throws {
        let rect1 = CGRect(center: .init(x: 10, y: 5), size: .init(width: 1, height: 1))
        XCTAssertEqual(CGPoint(x: 10, y: 5), rect1.center)

        let rect2 = CGRect(origin: .init(x: -20, y: 30), size: .init(width: 15, height: 10))
        XCTAssertEqual(CGPoint(x: -12.5, y: 35), rect2.center)
    }

    func test_with_center() throws {
        var rect = CGRect(origin: .zero, size: .init(width: 2, height: 2))

        rect = rect.with(center: .init(x: 3, y: 4))
        XCTAssertEqual(CGPoint(x: 2, y: 3), rect.origin)
        XCTAssertEqual(CGPoint(x: 3, y: 4), rect.center)

        rect = rect.with(centerX: 6)
        XCTAssertEqual(CGPoint(x: 5, y: 3), rect.origin)
        XCTAssertEqual(CGPoint(x: 6, y: 4), rect.center)

        rect = rect.with(centerY: -8)
        XCTAssertEqual(CGPoint(x: 5, y: -9), rect.origin)
        XCTAssertEqual(CGPoint(x: 6, y: -8), rect.center)

        rect = rect.with(centerX: 0, centerY: 0)
        XCTAssertEqual(CGPoint(x: -1, y: -1), rect.origin)
        XCTAssertEqual(CGPoint(x: 0, y: 0), rect.center)
    }
}
