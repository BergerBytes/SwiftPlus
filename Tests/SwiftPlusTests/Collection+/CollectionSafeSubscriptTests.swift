import XCTest
@testable import SwiftPlus

final class CollectionSafeSubscriptTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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

    let performanceTestArraySize = 100000
    let performanceAccessCount = 10000

    func test_safe_performance() throws {
        let array = [Int](repeating: .max, count: performanceTestArraySize)

        self.measure {
            for _ in 0...performanceAccessCount {
                _ = array[safe: Int.random(in: 0...performanceTestArraySize - 1)]
            }
        }
    }
    
    func test_unsafe_performance() throws {
        let array = [Int](repeating: .max, count: performanceTestArraySize)

        self.measure {
            for _ in 0...performanceAccessCount {
                _ = array[Int.random(in: 0...performanceTestArraySize - 1)]
            }
        }
    }
}
