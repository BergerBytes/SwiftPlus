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

final class QueueTests: QuickSpec {
    override class func spec() {
        describe("Queue") {
            describe("init") {
                it("creates empty queue on init") {
                    let queue = Queue<Int>()
                    expect(queue._array).to(equal([]))
                }

                it("creates array prefilled") {
                    let queue = Queue([1, 2, 3, 4, 5])
                    expect(queue._array).to(equal([1, 2, 3, 4, 5]))
                }
            }

            describe("enqueue") {
                it("enqueues single item") {
                    let queue = Queue<Int>()

                    queue.enqueue(1)
                    expect(queue._array).to(equal([1]))

                    queue.enqueue(2)
                    expect(queue._array).to(equal([1, 2]))

                    queue.enqueue(3)
                    expect(queue._array).to(equal([1, 2, 3]))
                }

                it("enqueues array of items") {
                    let queue = Queue<Int>()
                    expect(queue._array).to(equal([]))

                    queue.enqueue([1, 1, 1])
                    expect(queue._array).to(equal([1, 1, 1]))

                    queue.enqueue([2, 2, 2])
                    expect(queue._array).to(equal([1, 1, 1, 2, 2, 2]))

                    queue.enqueue([3, 3, 3])
                    expect(queue._array).to(equal([1, 1, 1, 2, 2, 2, 3, 3, 3]))
                }
            }

            describe("dequeuing") {
                describe("dequeue") {
                    it("returns next element") {
                        let queue = Queue([1, 2, 3, 4, 5])
                        expect(queue.dequeue()).to(equal(1))
                        expect(queue._array).to(equal([2, 3, 4, 5]))

                        expect(queue.dequeue()).to(equal(2))
                        expect(queue._array).to(equal([3, 4, 5]))

                        expect(queue.dequeue()).to(equal(3))
                        expect(queue._array).to(equal([4, 5]))

                        expect(queue.dequeue()).to(equal(4))
                        expect(queue._array).to(equal([5]))

                        expect(queue.dequeue()).to(equal(5))
                        expect(queue._array).to(equal([]))

                        expect(queue.dequeue()).to(beNil())
                        expect(queue._array).to(equal([]))
                    }
                }

                describe("dequeue next where") {
                    it("returns all matching elements") {
                        let queue = Queue([3, 0, 1, 2, 3, 3, 3, 4, 5, 3, 6, 7, 3])

                        expect(queue.dequeueAll { $0 == 3 }).to(equal([3, 3, 3, 3, 3, 3]))
                        expect(queue.dequeue()).to(equal(0))
                    }
                }
            }
        }
    }
}
