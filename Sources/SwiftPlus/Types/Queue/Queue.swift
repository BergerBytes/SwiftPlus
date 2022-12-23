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

/// First-in first-out queue (FIFO)
///
/// New elements are added to the end of the queue. Dequeuing pulls elements from
/// the front of the queue.
/// Enqueuing and dequeuing are O(1) operations.
public final class Queue<Element: Sendable> {
    public var _internalLinkedList = LinkedList<Element>()

    @inlinable public var isEmpty: Bool { _internalLinkedList.isEmpty }
    @inlinable public var isNotEmpty: Bool { !isEmpty }
    @inlinable public var count: Int { _internalLinkedList.count }

    public init() { }

    public init(array: [Element]) {
        _internalLinkedList = .init(array)
    }
}

public extension Queue {
    convenience init(_ sequence: some Sequence<Element>) {
        self.init(array: Array(sequence))
    }
}

public extension Queue {
    @inlinable func enqueue(_ element: Element) {
        _internalLinkedList.append(element)
    }

    @inlinable func enqueue(_ elements: [Element]) {
        _internalLinkedList.append(contentsOf: elements)
    }

    @inlinable func dequeue() -> Element? {
        _internalLinkedList.removeFirst()
    }

    @inlinable func dequeueNext(where predicate: (Element) -> Bool) -> Element? {
        _internalLinkedList.removeFirst(where: predicate)
    }

    @inlinable func dequeueNext<R>(where predicate: (Element) -> R?) -> R? {
        _internalLinkedList.removeFirst(where: predicate)
    }

    @inlinable func dequeueAll() -> [Element] {
        _internalLinkedList.removeAll()
    }

    @inlinable func dequeueAll(where predicate: (Element) -> Bool) -> [Element] {
        _internalLinkedList.removeAll(where: predicate)
    }

    @inlinable func dequeueAll<MappedElement>(where predicate: (Element) -> MappedElement?) -> [MappedElement]? {
        _internalLinkedList.removeAll(where: predicate)
    }

    @inlinable var peekNext: Element? {
        _internalLinkedList.first
    }

    @inlinable var peekLast: Element? {
        _internalLinkedList.last
    }

    @inlinable var peekAll: [Element] {
        _internalLinkedList.allElements()
    }

    @inlinable func removeAll() {
        _internalLinkedList.removeAll()
    }
}

// Internal extension for testing.
internal extension Queue {
    var _array: [Element?] {
        _internalLinkedList.allElements()
    }
}
