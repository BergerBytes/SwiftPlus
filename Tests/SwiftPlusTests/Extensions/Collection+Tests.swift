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

import Nimble
import Quick
@testable import SwiftPlus

final class CollectionTests: QuickSpec {
    override func spec() {
        describe("Collection") {
            describe("safe subscript") {
                it("is not nil for in bounds index") {
                    let array = [0, 1, 2, 3]
                    expect(array[safe: 0]).toNot(beNil())
                    expect(array[safe: 1]).toNot(beNil())
                    expect(array[safe: 2]).toNot(beNil())
                    expect(array[safe: 3]).toNot(beNil())
                }

                it("is nil for out of bounds index") {
                    let array = [0, 1, 2, 3]
                    expect(array[safe: -2]).to(beNil())
                    expect(array[safe: -1]).to(beNil())
                    expect(array[safe: 4]).to(beNil())
                    expect(array[safe: 5]).to(beNil())
                }

                it("finds correct value") {
                    let array = [0, 1, 2, 3]
                    expect(array[safe: 0]).to(equal(0))
                    expect(array[safe: 1]).to(equal(1))
                    expect(array[safe: 2]).to(equal(2))
                    expect(array[safe: 3]).to(equal(3))
                }
            }

            describe("isNotEmpty") {
                it("is true for non empty array") {
                    let array = [0, 1, 2, 3]
                    expect(array.isNotEmpty).to(beTrue())
                }
                
                it("is false for empty array") {
                    let array = []
                    expect(array.isNotEmpty).to(beFalse())
                }
            }
        }
    }
}
