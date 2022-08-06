//  Copyright © 2022 BergerBytes LLC. All rights reserved.
//
//  Permission to use, copy, modify, and/or distribute this software for any
//  purpose with or without fee is hereby granted, provided that the above
//  copyright notice and this permission notice appear in all copies.
//
//  THE SOFTWARE IS PROVIDED  AS IS AND THE AUTHOR DISCLAIMS ALL WARRANTIES
//  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
//  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
//  SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
//  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
//  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR
//  IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

@testable import SwiftPlus
import XCTest

final class CollectionSafeSubscriptTests: XCTestCase {
    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

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
