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

final class DictionaryTests: QuickSpec {
    override class func spec() {
        describe("Dictionary") {
            describe("Map Keys") {
                describe("mapUniqueKeys(transform:)") {
                    it("maps keys when no duplicates allowing nil keys") {
                        let input = ["one": 1, "two": 2, "Three": 3, "": 4]

                        let output = input.mapUniqueKeys { $0.first }

                        expect(output).to(equal(["o": 1, "t": 2, "T": 3, nil: 4]))
                    }
                }

                describe("compactMapUniqueKeys(transform:)") {
                    it("maps keys when no duplicates and drops nil keys") {
                        let input = ["one": 1, "two": 2, "Three": 3, "": 4]

                        let output = input.compactMapUniqueKeys { $0.first }

                        expect(output).to(equal(["o": 1, "t": 2, "T": 3]))
                    }
                }

                describe("mapKeys(transform:uniquingKeysWith:)") {
                    it("maps keys and resolves duplicates with closure") {
                        let input = ["one": 1, "two": 2, "three": 3, "": 4]

                        let output = input
                            .mapKeys {
                                $0.first
                            } uniquingKeysWith: {
                                max($0, $1)
                            }

                        expect(output).to(equal(["o": 1, "t": 3, nil: 4]))
                    }
                }

                describe("mapKeys(transform:uniquingKeysWith:)") {
                    it("maps keys, dropping nil keys and resolves duplicates with closure") {
                        let input = ["one": 1, "two": 2, "three": 3, "": 4]

                        let output = input
                            .compactMapKeys {
                                $0.first
                            } uniquingKeysWith: {
                                max($0, $1)
                            }

                        expect(output).to(equal(["o": 1, "t": 3]))
                    }
                }
            }
        }
    }
}
