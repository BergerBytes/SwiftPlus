import XCTest
import Foundation

final class CGRectMeasurementTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_diagonal() throws {
        let rect = CGRect(origin: .zero, size: .init(width: 2, height: 4))
        XCTAssertEqual(4.47213595499958, rect.diagonal)
        XCTAssertEqual(hypot(2, 4), rect.diagonal)
    }
    
    func test_diagonal_squared() throws {
        let rect = CGRect(origin: .zero, size: .init(width: 4, height: 8))
        XCTAssertEqual(pow(hypot(4, 8), 2), rect.diagonalSquared, accuracy: 0.0000000000001)
    }
}
