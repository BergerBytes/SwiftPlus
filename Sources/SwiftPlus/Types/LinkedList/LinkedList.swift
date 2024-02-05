//  Copyright © 2024 BergerBytes LLC. All rights reserved.
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

    public init() { }

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
    /// - Complexity: O(1)
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
    /// Removes the first element from the linked list that satisfies a specified predicate.
    ///
    /// This function iterates through the linked list, searching for the first element that matches the provided predicate. Upon finding such an element, the function excises it from the list. This is accomplished by adjusting the `next` and `previous` pointers of the neighboring nodes, thereby unlinking the target node from the list.
    ///
    /// The operation halts as soon as the first matching element is found and removed, making it unnecessary to traverse the entire list if the matching element is located early in the sequence.
    ///
    /// - Note: The `@discardableResult` attribute allows the caller to opt out of handling the function's return value without receiving a compiler warning. This is particularly useful when the caller is interested only in the side effect (removal of the element) rather than the value of the removed element.
    /// - Complexity: O(n) in the worst case, where n is the number of elements in the linked list. In the best case, when the element to be removed is near the start of the list, the complexity is O(1).
    /// - Parameter predicate: A closure that takes an element of the linked list as its argument and returns a Boolean. The function removes the first element for which this closure returns `true`.
    /// - Returns: The removed element if a matching element is found, otherwise `nil`.
    ///
    /// Example:
    ///
    /// ```
    /// let list = LinkedList<Int>()
    /// list.append(1)
    /// list.append(2)
    /// list.append(3)
    ///
    /// // Remove the first even number from the list
    /// if let removedElement = list.removeFirst(where: { $0 % 2 == 0 }) {
    ///     print(removedElement)  // Output: 2
    /// }
    /// print(list.allElements())  // Output: [1, 3]
    /// ```
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

    /// Removes all elements from the linked list that satisfy the given predicate and returns them as an array.
    ///
    /// This function, `removeAll(where:)`, enhances the `LinkedList` class by providing the ability to remove elements based on a predicate. It traverses the linked list, evaluating each element against the provided predicate. When an element meets the condition (predicate returns `true`), the function removes it from the list and adds it to an array of removed elements. This is achieved by efficiently updating the `next` and `previous` pointers of the adjacent nodes, effectively excising the node from the list.
    ///
    /// The function does not rely on the `Equatable` protocol to compare elements. Instead, it accepts any predicate, allowing for versatile removal criteria.
    ///
    /// - Note: The `@discardableResult` attribute permits ignoring the function's return value without compiler warnings, catering to use-cases focused solely on the side effects (element removal).
    /// - Complexity: Time: O(n), where n is the number of elements in the linked list. The function inspects each element once.
    /// - Complexity: Space: O(m), where m is the number of elements removed. This space is allocated for the array of removed elements.
    /// - Parameter predicate: A closure that takes an element of the linked list as its argument and returns a Boolean. Elements for which the predicate returns `true` are removed from the list and added to the returned array.
    /// - Returns: An array of elements that were removed from the linked list.
    ///
    /// Example:
    ///
    /// ```
    /// let list = LinkedList<Int>()
    /// list.append(1)
    /// list.append(2)
    /// list.append(3)
    ///
    /// // Remove all even numbers from the list
    /// let removedElements = list.removeAll(where: { $0 % 2 == 0 })
    /// print(removedElements)  // Output: [2]
    /// print(list.allElements())  // Output: [1, 3]
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

    /// Removes all elements from the linked list that satisfy the given predicate and returns them as an array of a specified type.
    ///
    /// This method iterates through the linked list, evaluating each element using the given predicate. If the predicate returns a non-nil value (indicating a match), the element is removed from the linked list, and the result of the predicate (converted value) is added to the result array. The method efficiently updates the internal structure of the linked list by modifying the `next` and `previous` pointers of the nodes surrounding the removed node.
    ///
    /// - Note: The `@discardableResult` attribute allows callers to ignore the return value of the method without a compiler warning, useful when the caller is only interested in the side effect of removing elements.
    /// - Complexity: Time: O(n), where n is the number of elements in the linked list. The method iterates through each element at most once.
    /// - Complexity: Space: O(m), where m is the number of elements removed (size of the returned array). This space is used to store the converted values of the elements removed.
    /// - Parameter predicate: A closure that takes an element of the linked list as its argument and returns an optional value of type `R`. If the return value is non-nil, the element is removed from the linked list, and its converted value is added to the return array.
    /// - Returns: An array of type `R`, containing the converted values of the elements removed from the linked list.
    ///
    /// Example:
    ///
    /// ```
    /// let list = LinkedList<Int>()
    /// list.append(1)
    /// list.append(2)
    /// list.append(3)
    /// list.append(4)
    ///
    /// // Remove all even numbers from the list and return them as strings
    /// let removedElements: [String] = list.removeAll { $0 % 2 == 0 ? "\($0)" : nil }
    /// print(removedElements)  // Output: ["2", "4"]
    /// print(list.allElements())  // Output: [1, 3]
    /// ```
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
        LinkedListIterator(startAt: head)
    }
}
