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

final class FloatingPointTests: QuickSpec {
    override class func spec() {
        describe("FloatingPoint") {
            it("squared") {
                expect(Float(5).squared()).to(equal(25))
                expect(Float(4.5).squared()).to(equal(20.25))
                expect(Double(10).squared()).to(equal(100))
                expect(Double(3.5).squared()).to(equal(12.25))
                expect(CGFloat(3.5).squared()).to(equal(12.25))
                expect(CGFloat(10).squared()).to(equal(100))
            }
        }
    }
}
