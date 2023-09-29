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

public extension UserDefaults {
    /// Encodes a `Codable` object and saves it to `UserDefaults` using the specified key.
    ///
    /// - Parameters:
    ///   - value: The `Codable` object to be stored.
    ///   - key: The key with which to associate the stored value.
    ///
    /// - Throws: If encoding the `Codable` object fails, throws an error.
    ///
    /// # Example
    /// ```
    /// let user = User(name: "John", age: 30)
    /// try? UserDefaults.standard.setCodable(user, forKey: "userKey")
    /// ```
    @inlinable
    func setCodable(_ value: (some Codable)?, forKey key: String) throws {
        let data = try JSONEncoder().encode(value)
        set(data, forKey: key)
    }

    /// Retrieves a `Codable` object associated with the specified key from `UserDefaults`.
    ///
    /// - Parameter key: The key associated with the value you want to retrieve.
    ///
    /// - Returns: The `Codable` object associated with the key, or `nil` if the key was not found.
    ///
    /// - Throws: If decoding the object fails, throws an error.
    ///
    /// # Example
    /// ```
    /// let retrievedUser: User? = try? UserDefaults.standard.codable(forKey: "userKey")
    /// ```
    @inlinable
    func codable<T: Codable>(forKey key: String) throws -> T? {
        guard let data = data(forKey: key) else { return nil }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
