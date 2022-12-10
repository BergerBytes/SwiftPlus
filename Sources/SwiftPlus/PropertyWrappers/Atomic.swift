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

/// Atomic is a property wrapper that provides thread-safety by using a lock to synchronize access to a wrapped value.
///
/// This code defines a property wrapper, Atomic, which provides thread-safety for a wrapped value.
/// In a concurrent or multithreaded environment, it is common for multiple threads to try to access and modify the same piece of data at the same time.
/// This can lead to race conditions and other synchronization issues, which can cause unpredictable behavior and bugs in your code.
///
/// The Atomic property wrapper uses a lock to synchronize access to the wrapped value, ensuring that only one thread can access the value at a time.
/// This prevents race conditions and other synchronization issues, making it safe to use the wrapped value in a concurrent environment.
///
/// In addition, the Atomic property wrapper implements the Sendable protocol, which means that it can be safely shared among different threads.
/// This allows you to use the Atomic property wrapper to synchronize access to shared data in a multithreaded environment.
@propertyWrapper
public struct Atomic<Value: Sendable>: Sendable {
    /// The underlying value to be synchronized on.
    private var value: Value

    /// The lock used to synchronize access to the underlying value.
    private let lock = NSLock()

    /// Initializes the property wrapper with the given value.
    ///
    /// - Parameter value: The value to be wrapped.
    public init(wrappedValue value: Value) {
        self.value = value
    }

    /// The synchronized value.
    @inlinable public var wrappedValue: Value {
        get { get() }
        set { set(newValue) }
    }

    /// Retrieves the synchronized value.
    ///
    /// - Returns: The synchronized value.
    public func get() -> Value {
        defer { lock.unlock() }
        lock.lock()
        return value
    }

    /// Sets the synchronized value.
    ///
    /// - Parameter newValue: The new value to be synchronized.
    public mutating func set(_ newValue: Value) {
        defer { lock.unlock() }
        lock.lock()
        value = newValue
    }
}
