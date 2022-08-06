import Nimble
import Quick
@testable import SwiftPlus

final class OptionalTests: QuickSpec {
    override func spec() {
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
        }
    }
}
