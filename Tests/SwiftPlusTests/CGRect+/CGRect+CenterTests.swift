import Foundation
import Nimble
import Quick
@testable import SwiftPlus

final class CGRectTests: QuickSpec {
    override func spec() {
        describe("CGRect") {
            describe("Center") {
                it("can init with center") {
                    let rect = CGRect(center: .init(x: 1, y: 1), size: .init(width: 1, height: 1))
                    expect(rect).to(equal(CGRect(origin: .init(x: 0.5, y: 0.5), size: .init(width: 1, height: 1))))
                }

                it("can get center") {
                    let rect1 = CGRect(center: .init(x: 10, y: 5), size: .init(width: 1, height: 1))
                    expect(rect1.center).to(equal(CGPoint(x: 10, y: 5)))

                    let rect2 = CGRect(origin: .init(x: -20, y: 30), size: .init(width: 15, height: 10))
                    expect(rect2.center).to(equal(CGPoint(x: -12.5, y: 35)))
                }

                it("can set center") {
                    var rect = CGRect(center: .init(x: 10, y: 5), size: .init(width: 1, height: 1))
                    expect(rect.center).to(equal(CGPoint(x: 10, y: 5)))

                    rect.center = .one
                    expect(rect.center).to(equal(CGPoint(x: 1, y: 1)))
                }

                it("can get centerX") {
                    let rect = CGRect(center: .init(x: 10, y: 5), size: .init(width: 1, height: 1))
                    expect(rect.centerX).to(equal(10))
                }

                it("can set centerX") {
                    var rect = CGRect(center: .init(x: 10, y: 5), size: .init(width: 1, height: 1))
                    rect.centerX = 50
                    expect(rect.centerX).to(equal(50))
                }

                it("can get centerY") {
                    let rect = CGRect(center: .init(x: 10, y: 5), size: .init(width: 1, height: 1))
                    expect(rect.centerY).to(equal(5))
                }

                it("can set centerY") {
                    var rect = CGRect(center: .init(x: 10, y: 5), size: .init(width: 1, height: 1))
                    rect.centerY = 50
                    expect(rect.centerY).to(equal(50))
                }

                describe("With") {
                    var rect: CGRect!

                    beforeEach {
                        rect = CGRect(origin: .zero, size: .init(width: 2, height: 2))
                    }

                    it("center") {
                        rect = rect.with(center: .init(x: 3, y: 4))
                        expect(rect.origin).to(equal(.init(x: 2, y: 3)))
                        expect(rect.center).to(equal(.init(x: 3, y: 4)))
                    }

                    it("nil center") {
                        let before = rect
                        rect = rect.with(center: nil)
                        expect(rect).to(equal(before))
                    }

                    it("centerX") {
                        rect = rect.with(centerX: 6)
                        expect(rect.origin).to(equal(.init(x: 5, y: 0)))
                        expect(rect.center).to(equal(.init(x: 6, y: 1)))
                    }

                    it("nil centerX") {
                        let before = rect
                        rect = rect.with(centerX: nil)
                        expect(rect).to(equal(before))
                    }

                    it("centerY") {
                        rect = rect.with(centerY: -8)
                        expect(rect.origin).to(equal(.init(x: 0, y: -9)))
                        expect(rect.center).to(equal(.init(x: 1, y: -8)))
                    }

                    it("nil centerY") {
                        let before = rect
                        rect = rect.with(centerY: nil)
                        expect(rect).to(equal(before))
                    }

                    it("centerX and centerY") {
                        rect = rect.with(centerX: 10, centerY: 20)
                        expect(rect.origin).to(equal(.init(x: 9, y: 19)))
                        expect(rect.center).to(equal(.init(x: 10, y: 20)))
                    }

                    it("nil centerX and centerY") {
                        let before = rect
                        rect = rect.with(centerX: nil, centerY: nil)
                        expect(rect).to(equal(before))
                    }
                }
            }
        }
    }
}
