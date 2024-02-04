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

/// An implementation of a linked list data structure in Swift.
///
/// This class provides basic operations for inserting and removing elements at the beginning and
/// end of the list, as well as accessing the first and last elements in the list. It also provides
/// a property to check if the list is empty.
///
/// Example:
/// ```
/// let list = LinkedList<Int>()
/// list.append(1)
/// list.append(2)
/// list.append(3)
///
/// let first = list.first // first will be 1
/// let last = list.last // last will be 3
/// let empty = list.isEmpty // empty will be false
///
/// list.removeFirst() // the first element in the list is now 2
/// ```
public class LinkedList<Element> {
    private var head: Node<Element>?
    private var tail: Node<Element>?

    public var isEmpty: Bool {
        head == nil
    }

    public var first: Element? {
        head?.value
    }

    public var last: Element? {
        tail?.value
    }

    /// The number of elements in the list.
    ///
    /// This property iterates through the list and counts the number of elements in it, so it has a
    /// time complexity of O(n).
    public var count: Int {
        var count = 0
        var currentNode = head
        while let _ = currentNode {
            currentNode = currentNode?.next
            count += 1
        }
        return count
    }

    public init() {}

    /// Initializes a new linked list with the elements of a sequence.
    ///
    /// This initializer takes a sequence of elements as an argument and uses it to build a new linked list.
    /// It iterates through the sequence and appends each element to the list using the `append(_:)`
    /// function.

    /// This initializer has a time complexity of O(n), where n is the length of the sequence.
    ///
    /// - Parameter sequence: The sequence of elements to use to initialize the linked list.
    public init(_ sequence: some Sequence<Element>) {
        for element in sequence {
            append(element)
        }
    }

    public func append(_ value: Element) {
        let newNode = Node(value: value)
        if let tailNode = tail {
            newNode.previous = tailNode
            tailNode.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }

    /// Appends the elements of a sequence to the linked list.
    ///
    /// This function takes a sequence of elements as an argument and appends each element to the list using
    /// the `append(_:)` function.
    ///
    /// This function has a time complexity of O(n), where n is the length of the sequence.
    ///
    /// - Parameter sequence: The sequence of elements to append to the linked list.
    @inlinable public func append(contentsOf sequence: some Sequence<Element>) {
        for element in sequence {
            append(element)
        }
    }

    /// Removes the first element from the linked list and returns it.
    ///
    /// This function removes the first element from the linked list and returns it, if the linked list is
    /// not empty. It also updates the head and tail pointers of the linked list to reflect the change.
    /// If the linked list is empty, this function returns nil.
    ///
    /// Example:
    /// ```
    /// let list = LinkedList<Int>()
    /// list.append(1)
    /// list.append(2)
    /// list.append(3)
    ///
    /// let first = list.removeFirst() // first is 1, the list now contains only the elements 2 and 3
    /// ```
    @discardableResult
    public func removeFirst() -> Element? {
        guard let headNode = head else {
            return nil
        }

        head = headNode.next
        head?.previous = nil
        if isEmpty {
            tail = nil
        }
        return headNode.value
    }

    /// Removes and returns the last element in the linked list.
    ///
    /// This function starts by checking if the list is empty. If it is, it returns `nil` immediately. If
    /// the list is not empty, it gets a reference to the last node in the list (the tail node) and sets
    /// the `previous` node of that node as the new tail. It then sets the `next` pointer of the new tail
    /// node to `nil` to remove the old tail node from the list. If the list is now empty, it sets the
    /// `head` pointer to `nil` as well. Finally, it returns the value of the old tail node.
    ///
    /// This function has a time complexity of O(1).
    ///
    /// - Returns: The value of the last element in the linked list, or `nil` if the list is empty.
    @discardableResult
    public func removeLast() -> Element? {
        guard let tailNode = tail else {
            return nil
        }

        tail = tailNode.previous
        tail?.next = nil
        if isEmpty {
            head = nil
        }
        return tailNode.value
    }

    /// Returns an array containing all of the elements in the linked list.
    ///
    /// This function iterates through the list using a while loop and adds each element to an array as it
    /// goes. It then returns the array containing all of the elements.
    ///
    /// This function has a time complexity of O(n), where n is the number of elements in the linked list.
    ///
    /// - Returns: An array containing all of the elements in the linked list.
    public func allElements() -> [Element] {
        var elements = [Element]()
        var currentNode = head
        while let node = currentNode {
            elements.append(node.value)
            currentNode = node.next
        }
        return elements
    }

    @discardableResult
    public func removeAll() -> [Element] {
        var elements = [Element]()

        var currentNode = head
        while let node = currentNode {
            elements.append(node.value)
            currentNode = node.next
        }

        head = nil
        tail = nil

        return elements
    }
}

public extension LinkedList {
    /// Removes the first element in the linked list that matches a given predicate.
    ///
    /// This function takes a predicate as an argument and iterates through the elements in the list until
    /// it finds an element that matches the predicate. If it finds a matching element, it removes it from
    /// the list by updating the `next` and `previous` pointers of the surrounding nodes.
    ///
    /// This function has a time complexity of O(n), where n is the number of elements in the linked list.
    ///
    /// - Parameter predicate: The predicate to use when searching for the element to remove.
    /// - Returns: The removed element, or `nil` if no matching element was found.
    @discardableResult
    func removeFirst(where predicate: (Element) -> Bool) -> Element? {
        var currentNode = head
        while let node = currentNode {
            if predicate(node.value) {
                if let previous = node.previous {
                    previous.next = node.next
                } else {
                    head = node.next
                }
                if let next = node.next {
                    next.previous = node.previous
                } else {
                    tail = node.previous
                }
                return node.value
            }
            currentNode = node.next
        }
        return nil
    }

    func removeFirst<R>(where predicate: (Element) -> R?) -> R? {
        var currentNode = head
        while let node = currentNode {
            if let convertedValue = predicate(node.value) {
                if let previous = node.previous {
                    previous.next = node.next
                } else {
                    head = node.next
                }
                if let next = node.next {
                    next.previous = node.previous
                } else {
                    tail = node.previous
                }
                return convertedValue
            }
            currentNode = node.next
        }
        return nil
    }

    /// Removes all elements that match a given predicate and return them as an array.
    ///
    /// This extension adds a new function called `removeAll(where:)` to the `LinkedList` class. This
    /// function takes a predicate as an argument and removes all of the elements in the list that match
    /// the predicate. It also returns the removed elements as an array. To do this, it iterates through
    /// the list using a while loop and checks each element to see if it matches the predicate. If it
    /// does, it removes the element from the list by updating the `next` and `previous` pointers of the
    /// surrounding nodes, and it also adds the element to the array of removed elements.
    ///
    /// This function uses the `Equatable` protocol to compare the elements in the list, so it will only
    /// work if the element type of the linked list conforms to that protocol.
    ///
    /// Example:
    ///
    /// ```
    /// let list = LinkedList<Int>()
    /// list.append(1)
    /// list.append(2)
    /// list.append(3)
    ///
    /// let removedElements = list.removeAll(where: { $0 == 2 })
    /// // removedElements will be [2]
    /// // the list now contains only the elements 1 and 3
    /// ```
    @discardableResult
    func removeAll(where predicate: (Element) -> Bool) -> [Element] {
        var elements = [Element]()

        var currentNode = head
        while let node = currentNode {
            if predicate(node.value) {
                elements.append(node.value)

                if let previous = node.previous {
                    previous.next = node.next
                } else {
                    head = node.next
                }
                if let next = node.next {
                    next.previous = node.previous
                } else {
                    tail = node.previous
                }
            }

            currentNode = node.next
        }

        return elements
    }

    @discardableResult
    func removeAll<R>(where predicate: (Element) -> R?) -> [R] {
        var elements = [R]()

        var currentNode = head
        while let node = currentNode {
            if let convertedValue = predicate(node.value) {
                elements.append(convertedValue)

                if let previous = node.previous {
                    previous.next = node.next
                } else {
                    head = node.next
                }
                if let next = node.next {
                    next.previous = node.previous
                } else {
                    tail = node.previous
                }
            }

            currentNode = node.next
        }

        return elements
    }
}

extension LinkedList: Sequence {
    public struct LinkedListIterator: IteratorProtocol {
        private var current: Node<Element>?

        fileprivate init(startAt node: Node<Element>?) {
            current = node
        }

        public mutating func next() -> Element? {
            guard let node = current else { return nil }
            current = node.next
            return node.value
        }
    }

    public func makeIterator() -> LinkedListIterator {
        return LinkedListIterator(startAt: head)
    }
}
