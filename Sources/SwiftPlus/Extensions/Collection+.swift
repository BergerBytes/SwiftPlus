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

public extension Collection {
    @inlinable var isNotEmpty: Bool {
        !isEmpty
    }

    @inlinable subscript(safe index: Index?) -> Iterator.Element? {
        guard let index else {
            return nil
        }

        return self[safe: index]
    }

    @inlinable subscript(safe index: Index) -> Iterator.Element? {
        indices.contains(index) ? self[index] : nil
    }

    /// Returns true if any predicate returns true.
    ///
    /// Once a predicate returns true the function returns and execution stops.
    /// - Parameter predicate: Predicate to invoke for each element.
    /// - Returns: Returns true if any predicate returns true.
    @inlinable func any(where predicate: (Self.Element) throws -> Bool) rethrows -> Bool {
        for element in self {
            if try predicate(element) {
                return true
            }
        }

        return false
    }

    /// Returns true if all predicates returns true.
    ///
    /// Once a predicate returns false the function returns and execution stops.
    /// - Parameter predicate: Predicate to invoke for each element.
    /// - Returns: Returns true if all predicates returns true.
    @inlinable func all(match predicate: (Self.Element) throws -> Bool) rethrows -> Bool {
        for element in self {
            if !(try predicate(element)) {
                return false
            }
        }

        return true
    }

    /// Returns a set containing the non-nil results of calling the given transformation with each element of this sequence.
    ///
    /// - Parameter transform: A closure that accepts an element of this sequence as its argument and returns an optional value.
    /// - Returns: A set of the non-nil results of calling transform with each element of the sequence.
    @inlinable func compactMapSet<T>(_ transform: (Element) throws -> T?) rethrows -> Set<T> {
        .init(try compactMap(transform))
    }

    /// Returns the maximum element in the sequence, using the given key path as the comparison between elements.
    ///
    /// - Parameter keyPath: They key path of the parameter that should be used to compare against.
    /// - Returns: The sequence’s maximum element if the sequence is not empty; otherwise, nil.
    @inlinable func max(by keyPath: KeyPath<Element, some Comparable>) -> Element? {
        self.max { a, b in
            a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }

    /// Returns the minimum element in the sequence, using the given key path as the comparison between elements.
    ///
    /// - Parameter keyPath: They key path of the parameter that should be used to compare against.
    /// - Returns: The sequence’s minimum element if the sequence is not empty; otherwise, nil.
    @inlinable func min(by keyPath: KeyPath<Element, some Comparable>) -> Element? {
        self.min { a, b in
            a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
}

public extension RangeReplaceableCollection {
    /// Removes the first element of the collection satisfies the given predicate.
    ///
    /// - Parameter predicate: A closure that takes an element as its argument and returns a Boolean value that indicates whether the passed element represents a match.
    /// - Returns: The removed element for which predicate returns true. If no elements in the collection satisfy the given predicate, returns nil.
    @discardableResult
    @inlinable mutating func removeFirst(where predicate: @escaping (Element) throws -> Bool) rethrows -> Element? {
        guard let index = try firstIndex(where: predicate) else {
            return nil
        }

        return remove(at: index)
    }
}

public extension Set {
    /// Inserts the non-nil elements of the given sequence into the set.
    ///
    /// If the set already contains one or more elements that are also in
    /// `other`, the existing members are kept. If `other` contains multiple
    /// instances of equivalent elements, only the first instance is kept.
    ///
    ///     var attendees: Set = ["Alicia", "Bethany", "Diana"]
    ///     let visitors = ["Diana", "Marcia", "Nathaniel"]
    ///     attendees.formUnion(visitors)
    ///     print(attendees)
    ///     // Prints "["Diana", "Nathaniel", "Bethany", "Alicia", "Marcia"]"
    ///
    /// - Parameter other: A sequence of elements. `other` must be finite.
    @inlinable mutating func compactFormUnion(_ other: some Sequence<Element?>) {
        formUnion(other.compactMap { $0 })
    }
}
