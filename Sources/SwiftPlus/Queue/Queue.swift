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
    private var array = [Element?]()
    private var head = 0

    public var isEmpty: Bool { count == 0 }
    public var count: Int { array.count - head }

    public init() { }

    public init(_ sequence: any Sequence<Element>) {
        array = Array(sequence)
    }
}

public extension Queue {
    func enqueue(_ element: Element) {
        array.append(element)
    }

    func enqueue(_ elements: [Element]) {
        array.append(contentsOf: elements)
    }

    func dequeue() -> Element? {
        guard let element = array[safe: head] else {
            return nil
        }

        array[head] = nil
        head += 1

        let percentage = Double(head) / Double(array.count)
        if array.count > 50, percentage > 0.25 {
            array.removeFirst(head)
            head = 0
        }

        return element
    }

    func dequeueNext(where predicate: (Element) -> Bool) -> Element? {
        var index = head
        while let item = array[safe: index] as? Element {
            if predicate(item) {
                array.remove(at: index)
                return item
            }

            index += 1
        }

        return nil
    }

    func dequeueNext<R>(where predicate: (Element) -> R?) -> R? {
        guard count > 0 else {
            return nil
        }

        var index = head
        while let item = array[safe: index] as? Element {
            if let item = predicate(item) {
                array.remove(at: index)
                return item
            }

            index += 1
        }

        return nil
    }

    func dequeueAll() -> some Sequence<Element> {
        defer { removeAll() }
        guard count > 0 else {
            return []
        }

        return array[head ... count - 1]
            .compactMap { $0 }
    }

    func dequeueAll(where predicate: (Element) -> Bool) -> [Element] {
        guard count > 0 else {
            return []
        }

        var results = [Element]()
        array.removeAll { item in
            if let item = item {
                if predicate(item) {
                    results.append(item)
                    return true
                }
            }

            return false
        }

        let percentage = Double(head) / Double(array.count)
        if array.count > 50, percentage > 0.25 {
            array.removeFirst(head)
            head = 0
        }

        return results
    }

    func dequeueAll<MappedElement>(where predicate: (Element) -> MappedElement?) -> [MappedElement]? {
        guard count > 0 else {
            return nil
        }

        var results = [MappedElement]()
        array.removeAll { item in
            if let item = item {
                if let match = predicate(item) {
                    results.append(match)
                    return true
                }
            }

            return false
        }

        head = 0

        return results
    }

    var peekNext: Element? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }

    var peekLast: Element? {
        if isEmpty {
            return nil
        } else {
            return array.last as? Element
        }
    }

    var peekAll: [Element] {
        array[head ... count - 1]
            .compactMap { $0 }
    }

    func removeAll(keepingCapacity keepCapacity: Bool = false) {
        array.removeAll(keepingCapacity: keepCapacity)
        head = 0
    }
}

// Internal extension for testing.
internal extension Queue {
    var _array: [Element?] {
        array
    }

    var _head: Int {
        head
    }
}
