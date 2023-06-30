//  Copyright © 2023 BergerBytes LLC. All rights reserved.
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

final class TaskTests: QuickSpec {
    override class func spec() {
        describe("sleep") {
            describe("seconds") {
                it("waits the correct amount of time") {
                    waitUntil { done in
                        Task {
                            let time = CFAbsoluteTimeGetCurrent()
                            try await Task.sleep(seconds: 0.1)
                            expect(CFAbsoluteTimeGetCurrent() - time).to(beCloseTo(0.1, within: 0.01))
                            done()
                        }
                    }
                }
            }

            describe("milliseconds") {
                it("waits the correct amount of time") {
                    waitUntil { done in
                        Task {
                            let time = CFAbsoluteTimeGetCurrent()
                            try await Task.sleep(milliseconds: 16)
                            expect(CFAbsoluteTimeGetCurrent() - time).to(beCloseTo(0.016, within: 0.005))
                            done()
                        }
                    }
                }
            }
        }
    }
}
