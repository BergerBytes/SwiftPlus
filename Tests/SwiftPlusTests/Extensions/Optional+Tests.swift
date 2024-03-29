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

final class OptionalTests: QuickSpec {
    override class func spec() {
        describe("Optional") {
            describe("isNil") {
                it("object is nil") {
                    let foo: String? = nil
                    expect(foo.isNil).to(beTrue())
                }

                it("object is not nil") {
                    let foo: String? = "bar"
                    expect(foo.isNil).to(beFalse())
                }
            }

            describe("isNotNil") {
                it("object is nil") {
                    let foo: String? = nil
                    expect(foo.isNotNil).to(beFalse())
                }

                it("object is not nil") {
                    let foo: String? = "bar"
                    expect(foo.isNotNil).to(beTrue())
                }
            }
            
            describe("transform") {
                it("passes the optional") {
                    let foo: Int? = 5
                    expect(foo.transform { String($0 ?? -1) }).to(equal("5"))
                }
                
                it("passes a nil") {
                    let foo: Int? = nil
                    expect(foo.transform { String($0 ?? -1) }).to(equal("-1"))
                }
            }
            
            describe("unwrappedTransform") {
                it("passes the unwrapped value") {
                    let foo: Int? = 5
                    expect(foo.unwrappedTransform { String($0) }).to(equal("5"))
                }
                
                it("never calls the closure and returns nil") {
                    let foo: Int? = nil
                    expect(foo.unwrappedTransform { String($0) }).to(beNil())
                }
            }
        }
    }
}
