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

private struct Model: Codable {
    @TimeZoneIdentifierCodable
    var timezone: TimeZone
}

class TimeZoneIdentifierCodableTests: QuickSpec {
    override class func spec() {
        describe("TimeZoneIdentifierCodable") {
            context("when encoding") {
                it("should encode") {
                    let originalModel = Model(timezone: TimeZone(identifier: "America/Chicago")!)
                    let encoder = JSONEncoder()
                    let decoder = JSONDecoder()

                    // Encode
                    var encodedData: Data!
                    expect { encodedData = try encoder.encode(originalModel) }.notTo(throwError())

                    // Decode
                    var decodedModel: Model!
                    expect { decodedModel = try decoder.decode(Model.self, from: encodedData) }.notTo(throwError())

                    // Assert
                    expect(decodedModel.timezone).to(equal(originalModel.timezone))
                }
            }

            context("decoding") {
                it("decodes correctly") {
                    let data = """
                    {
                        "timezone": "America/Chicago"
                    }
                    """.data(using: .utf8)!

                    let decoder = JSONDecoder()

                    // Decode
                    var decodedModel: Model!
                    expect { decodedModel = try decoder.decode(Model.self, from: data) }.notTo(throwError())

                    // Assert
                    expect(decodedModel.timezone).to(equal(TimeZone(identifier: "America/Chicago")))
                }

                it("should throw error when the timeZone identifier is invalid") {
                    let invalidTimeZoneIdentifierJSON = """
                    {
                        "timezone": "Invalid/Identifier"
                    }
                    """.data(using: .utf8)!

                    let decoder = JSONDecoder()

                    // Decode
                    expect { try decoder.decode(Model.self, from: invalidTimeZoneIdentifierJSON) }.to(throwError())
                }
            }
        }
    }
}
