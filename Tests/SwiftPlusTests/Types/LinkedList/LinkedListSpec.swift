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

import Foundation
import Nimble
import Quick
@testable import SwiftPlus

class LinkedListSpec: QuickSpec {
    override func spec() {
        describe("LinkedList") {
            var list: LinkedList<Int>!

            beforeEach {
                list = LinkedList<Int>()
            }

            it("is empty when first created") {
                expect(list.isEmpty).to(beTrue())
            }

            it("has a first element after appending one element") {
                list.append(1)
                expect(list.first).to(equal(1))
            }

            it("has a last element after appending one element") {
                list.append(1)
                expect(list.last).to(equal(1))
            }

            it("has no first element after removing one element") {
                list.append(1)
                list.removeFirst()
                expect(list.first).to(beNil())
            }

            it("has no last element after removing one element") {
                list.append(1)
                list.removeFirst()
                expect(list.last).to(beNil())
            }

            it("has a first and last element after appending two elements") {
                list.append(1)
                list.append(2)
                expect(list.first).to(equal(1))
                expect(list.last).to(equal(2))
            }

            it("has a first and last element after appending three elements") {
                list.append(1)
                list.append(2)
                list.append(3)
                expect(list.first).to(equal(1))
                expect(list.last).to(equal(3))
            }

            it("returns the correct number of elements") {
                list.append(1)
                list.append(2)
                list.append(3)
                expect(list.allElements().count).to(equal(3))
            }

            it("returns all elements in the correct order") {
                list.append(1)
                list.append(2)
                list.append(3)
                expect(list.allElements()).to(equal([1, 2, 3]))
            }

            it("removes all elements that match the given predicate") {
                list.append(1)
                list.append(2)
                list.append(3)
                list.removeAll(where: { $0 == 2 })
                expect(list.allElements()).to(equal([1, 3]))
            }

            it("returns the correct elements after removing all elements that match the given predicate") {
                list.append(1)
                list.append(2)
                list.append(3)
                let removedElements = list.removeAll(where: { $0 == 2 })
                expect(removedElements).to(equal([2]))
            }
        }
    }
}
