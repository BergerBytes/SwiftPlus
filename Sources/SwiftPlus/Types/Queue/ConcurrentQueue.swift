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

/// Thread safe wrapper around ``Queue``
public final class ConcurrentQueue<Element: Sendable> {
    private let internalQueue: Queue<Element>
    private let lock = NSLock()

    public init() {
        internalQueue = .init()
    }

    public init(_ sequence: some Sequence<Element>) {
        internalQueue = .init(sequence)
    }
}

public extension ConcurrentQueue {
    var isEmpty: Bool {
        defer { lock.unlock() }
        lock.lock()

        return internalQueue.isEmpty
    }

    var count: Int {
        defer { lock.unlock() }
        lock.lock()

        return internalQueue.count
    }

    func enqueue(_ element: Element) {
        defer { lock.unlock() }
        lock.lock()

        internalQueue.enqueue(element)
    }

    func enqueue(_ elements: [Element]) {
        defer { lock.unlock() }
        lock.lock()

        internalQueue.enqueue(elements)
    }

    func dequeue() -> Element? {
        defer { lock.unlock() }
        lock.lock()

        return internalQueue.dequeue()
    }

    func dequeueNext(where predicate: (Element) -> Bool) -> Element? {
        defer { lock.unlock() }
        lock.lock()

        return internalQueue.dequeueNext(where: predicate)
    }

    func dequeueNext<R>(where predicate: (Element) -> R?) -> R? {
        defer { lock.unlock() }
        lock.lock()

        return internalQueue.dequeueNext(where: predicate)
    }

    func dequeueAll() -> [Element] {
        defer { lock.unlock() }
        lock.lock()

        return internalQueue.dequeueAll()
    }

    func dequeueAll(where predicate: (Element) -> Bool) -> [Element] {
        defer { lock.unlock() }
        lock.lock()

        return internalQueue.dequeueAll(where: predicate)
    }

    func dequeueAll<MappedElement: Sendable>(where predicate: (Element) -> MappedElement?) -> [MappedElement]? {
        defer { lock.unlock() }
        lock.lock()

        return internalQueue.dequeueAll(where: predicate)
    }

    var peekNext: Element? {
        defer { lock.unlock() }
        lock.lock()

        return internalQueue.peekNext
    }

    var peekLast: Element? {
        defer { lock.unlock() }
        lock.lock()

        return internalQueue.peekLast
    }

    var peekAll: [Element] {
        defer { lock.unlock() }
        lock.lock()

        return internalQueue.peekAll
    }

    func removeAll() {
        defer { lock.unlock() }
        lock.lock()

        internalQueue.removeAll()
    }
}

internal extension ConcurrentQueue {
    var _array: [Element?] {
        defer { lock.unlock() }
        lock.lock()

        return internalQueue._array
    }
}
