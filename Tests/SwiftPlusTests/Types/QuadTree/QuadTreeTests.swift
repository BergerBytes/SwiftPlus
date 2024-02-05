//  Copyright © 2024 BergerBytes LLC. All rights reserved.
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

class QuadTreeTests: QuickSpec {
    struct Box: QuadTreeElement {
        let id: String
        let bounds: CGRect

        init(id: String = UUID().uuidString, bounds: CGRect) {
            self.id = id
            self.bounds = bounds
        }
    }

    override class func spec() {
        describe("QuadTree") {
            it("test") {
                let tree = QuadTree<Box>(region: CGRect(origin: .zero, size: .init(width: 100, height: 100)))

                for _ in 0 ... 100 {
                    tree.insert(element: .init(bounds: .init(origin: .init(x: .random(in: 1 ... 90), y: .random(in: 1 ... 90)), size: .init(width: .random(in: 1 ... 10), height: .random(in: 1 ... 10)))))
                }

                tree.insert(element: .init(id: "test_id", bounds: .init(center: .init(x: 90, y: 90), size: .init(width: 5, height: 5))))

                expect(tree.search(point: .init(x: 90, y: 90)).map(\.id)).to(contain(["test_id"]))
                expect(tree.search(region: .init(origin: .init(x: 80, y: 80), size: .init(width: 10, height: 10))).map(\.id)).to(contain(["test_id"]))
            }
        }
    }
}
