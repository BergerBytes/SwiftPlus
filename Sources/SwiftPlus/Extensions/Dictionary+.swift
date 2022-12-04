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

// https://forums.swift.org/t/mapping-dictionary-keys/15342/3
public extension Dictionary {
    /// Same values, corresponding to `map`ped keys.
    ///
    /// - Parameter transform: Accepts each key of the dictionary as its parameter
    ///   and returns a key for the new dictionary.
    /// - Postcondition: The collection of transformed keys must not contain duplicates.
    @inlinable func mapUniqueKeys<Transformed>(_ transform: (Key) throws -> Transformed) rethrows -> [Transformed: Value] {
        .init(uniqueKeysWithValues: try map { (try transform($0.key), $0.value) })
    }

    /// Transforms dictionary keys without modifying values.
    /// Deduplicates transformed keys.
    ///
    /// Example:
    /// ```
    /// ["one": 1, "two": 2, "three": 3, "": 4].mapKeys({ $0.first }, uniquingKeysWith: { max($0, $1) })
    /// // [Optional("o"): 1, Optional("t"): 3, nil: 4]
    /// ```
    ///
    /// - Parameters:
    ///   - transform: A closure that accepts each key of the dictionary as
    ///   its parameter and returns a transformed key of the same or of a different type.
    ///   - combine:A closure that is called with the values for any duplicate
    ///   keys that are encountered. The closure returns the desired value for
    ///   the final dictionary.
    /// - Returns: A dictionary containing the transformed keys and values of this dictionary.
    @inlinable func mapKeys<Transformed>(
        map transform: (Key) throws -> Transformed,
        uniquingKeysWith combine: (Value, Value) throws -> Value
    ) rethrows -> [Transformed: Value] {
        try .init(
            map { (try transform($0.key), $0.value) },
            uniquingKeysWith: combine
        )
    }

    /// Transforms dictionary keys without modifying values.
    /// Drops (key, value) pairs where the transform results in a nil key.
    /// Deduplicates transformed keys.
    ///
    /// Example:
    /// ```
    /// ["one": 1, "two": 2, "three": 3, "": 4].compactMapKeys({ $0.first }, uniquingKeysWith: { max($0, $1) })
    /// // ["o": 1, "t": 3]
    /// ```
    ///
    /// - Parameters:
    ///   - transform: A closure that accepts each key of the dictionary as
    ///   its parameter and returns an optional transformed key of the same or of a different type.
    ///   - combine: A closure that is called with the values for any duplicate
    ///   keys that are encountered. The closure returns the desired value for
    ///   the final dictionary.
    /// - Returns: A dictionary containing the non-nil transformed keys and values of this dictionary.
    @inlinable func compactMapKeys<T>(
        map transform: (Key) throws -> T?,
        uniquingKeysWith combine: (Value, Value) throws -> Value
    ) rethrows -> [T: Value] {
        try .init(compactMap { (try transform($0.key), $0.value) as? (T, Value) }, uniquingKeysWith: combine)
    }

    /// `compactMap`ped keys, with their values.
    ///
    /// - Parameter transform: Accepts each key of the dictionary as its parameter
    ///   and returns a potential key for the new dictionary.
    /// - Postcondition: The collection of transformed keys must not contain duplicates.
    @inlinable func compactMapUniqueKeys<Transformed>(_ transform: (Key) throws -> Transformed?) rethrows -> [Transformed: Value] {
        .init(uniqueKeysWithValues: try compactMap { key, value in try transform(key).map { ($0, value) } })
    }
}
