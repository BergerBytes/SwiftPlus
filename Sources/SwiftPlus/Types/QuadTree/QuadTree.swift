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

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 8.0, *)
public class QuadTree<Element: QuadTreeElement> {
    var root: Node<Element>?
    public let minimumQuadSize: CGFloat
    public let maxDepth: Int

    public init(region: CGRect, minimumQuadSize: CGFloat = 1.0, maxDepth: Int = 10) {
        root = Node(region: region)
        self.minimumQuadSize = minimumQuadSize
        self.maxDepth = maxDepth
    }

    public func insert(element: Element) {
        root = insert(fromNode: root, element: element, currentDepth: 0)
    }

    @discardableResult
    private func insert(fromNode node: Node<Element>?, element: Element, currentDepth: Int) -> Node<Element> {
        guard let node = node else {
            let newNode = Node<Element>(region: element.bounds)
            newNode.elements.append(element)
            return newNode
        }

        if node.region.intersects(element.bounds) {
            let width = node.region.maxX - node.region.minX
            let height = node.region.maxY - node.region.minY
            if width <= minimumQuadSize && height <= minimumQuadSize || currentDepth >= maxDepth {
                // The node is a leaf node or max depth reached
                node.elements.append(element)
            } else {
                // Subdivide the node and attempt to insert the element into the appropriate children
                if node.topLeft == nil { // Subdivide only if not already subdivided
                    subdivide(node: node)
                }
                let intersections = countIntersectingChildren(node: node, element: element)
                if intersections >= 2 {
                    // Element intersects with 2 or more child nodes, add it to the parent node
                    node.elements.append(element)
                } else {
                    // Element intersects with 1 child node, insert into that child node
                    insertInChildNodes(node: node, element: element, currentDepth: currentDepth)
                }
            }
        }
        return node
    }

    private func countIntersectingChildren(node: Node<Element>, element: Element) -> Int {
        let childNodes = [node.topLeft, node.topRight, node.bottomLeft, node.bottomRight]
        return childNodes.reduce(0) { count, childNode in
            count + (childNode?.region.intersects(element.bounds) == true ? 1 : 0)
        }
    }

    private func insertInChildNodes(node: Node<Element>, element: Element, currentDepth: Int) {
        let nextDepth = currentDepth + 1
        if let topLeft = node.topLeft, topLeft.region.intersects(element.bounds) {
            insert(fromNode: topLeft, element: element, currentDepth: nextDepth)
        }
        if let topRight = node.topRight, topRight.region.intersects(element.bounds) {
            insert(fromNode: topRight, element: element, currentDepth: nextDepth)
        }
        if let bottomLeft = node.bottomLeft, bottomLeft.region.intersects(element.bounds) {
            insert(fromNode: bottomLeft, element: element, currentDepth: nextDepth)
        }
        if let bottomRight = node.bottomRight, bottomRight.region.intersects(element.bounds) {
            insert(fromNode: bottomRight, element: element, currentDepth: nextDepth)
        }
    }

    private func subdivide(node: Node<Element>) {
        node.topLeft = Node(region: node.region.topLeftRect, parent: node)
        node.topRight = Node(region: node.region.topRightRect, parent: node)
        node.bottomLeft = Node(region: node.region.bottomLeftRect, parent: node)
        node.bottomRight = Node(region: node.region.bottomRightRect, parent: node)
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 8.0, *)
public extension QuadTree {
    // Search for elements containing the point
    func search(point: CGPoint) -> [Element] {
        search(point: point, fromNode: root)
    }

    private func search(point: CGPoint, fromNode node: Node<Element>?) -> [Element] {
        var results = [Element]()

        guard let node = node else {
            return []
        }

        if node.region.contains(point) {
            for element in node.elements {
                if element.bounds.contains(point) {
                    results.append(element)
                }
            }

            if let topLeft = node.topLeft {
                results.append(contentsOf: search(point: point, fromNode: topLeft))
            }
            if let topRight = node.topRight {
                results.append(contentsOf: search(point: point, fromNode: topRight))
            }
            if let bottomLeft = node.bottomLeft {
                results.append(contentsOf: search(point: point, fromNode: bottomLeft))
            }
            if let bottomRight = node.bottomRight {
                results.append(contentsOf: search(point: point, fromNode: bottomRight))
            }
        }

        return results
    }

    // Search for elements intersecting with the region
    func search(region: CGRect) -> [Element] {
        search(region: region, fromNode: root)
    }

    private func search(region: CGRect, fromNode node: Node<Element>?) -> [Element] {
        var results = [Element]()

        guard let node = node else {
            return []
        }

        if node.region.intersects(region) {
            for element in node.elements {
                if element.bounds.intersects(region) {
                    results.append(element)
                }
            }

            if let topLeft = node.topLeft {
                results.append(contentsOf: search(region: region, fromNode: topLeft))
            }
            if let topRight = node.topRight {
                results.append(contentsOf: search(region: region, fromNode: topRight))
            }
            if let bottomLeft = node.bottomLeft {
                results.append(contentsOf: search(region: region, fromNode: bottomLeft))
            }
            if let bottomRight = node.bottomRight {
                results.append(contentsOf: search(region: region, fromNode: bottomRight))
            }
        }

        return results
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 8.0, *)
public extension QuadTree {
    @discardableResult
    func remove(element: Element) -> Bool {
        guard let root = root else {
            return false
        }
        return remove(node: root, element: element, currentDepth: 0)
    }

    private func remove(node: Node<Element>, element: Element, currentDepth: Int) -> Bool {
        guard node.region.contains(element.bounds.center) else {
            return false
        }

        if node.elements.removeFirst(where: { $0.id == element.id }).isNotNil {
            return true
        }

        if node.topLeft != nil {
            let removed = remove(node: node.topLeft!, element: element, currentDepth: currentDepth + 1) ||
                remove(node: node.topRight!, element: element, currentDepth: currentDepth + 1) ||
                remove(node: node.bottomLeft!, element: element, currentDepth: currentDepth + 1) ||
                remove(node: node.bottomRight!, element: element, currentDepth: currentDepth + 1)

            if removed {
                attemptCollapseIfPossible(node: node, currentDepth: currentDepth)
            }
            return removed
        }

        return false
    }

    private func attemptCollapseIfPossible(node: Node<Element>, currentDepth: Int) {
        guard let parent = node.parent else { return }

        if node.isEmpty, parent.allChildrenAreEmpty, currentDepth < maxDepth {
            parent.topLeft = nil
            parent.topRight = nil
            parent.bottomLeft = nil
            parent.bottomRight = nil
        }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 8.0, *)
public protocol QuadTreeElement: Identifiable {
    var bounds: CGRect { get }
}

public protocol Bounded {
    func contains(point: SIMD2<Float>) -> Bool
    func intersects(region: CGRect) -> Bool
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 8.0, *)
public extension QuadTree {
    class Node<T: QuadTreeElement> {
        var elements = LinkedList<T>()
        var region: CGRect
        var topLeft: Node<T>?
        var topRight: Node<T>?
        var bottomLeft: Node<T>?
        var bottomRight: Node<T>?

        weak var parent: QuadTree.Node<Element>?

        init(region: CGRect, parent: QuadTree.Node<Element>? = nil) {
            self.region = region
            self.parent = parent
        }

        var isEmpty: Bool {
            elements.isEmpty && topLeft == nil
        }

        var allChildrenAreEmpty: Bool {
            topLeft?.isEmpty ?? true &&
                topRight?.isEmpty ?? true &&
                bottomLeft?.isEmpty ?? true &&
                bottomRight?.isEmpty ?? true
        }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 8.0, *)
extension QuadTree: CustomDebugStringConvertible {
    public var debugDescription: String {
        func visualizeNode(_ node: Node<Element>?, depth: Int, prefix: String) -> String {
            guard let node = node, depth < maxDepth else { return prefix + "• (Empty)\n" }

            var result = prefix + "• Region: \(node.region)\n"
            result += prefix + "  Elements: [\(node.elements.map { String(describing: $0.bounds) }.joined(separator: ", "))]\n"

            // Adjust the visual spacing based on depth
            let newPrefix = prefix + "  "

            result += visualizeNode(node.topLeft, depth: depth + 1, prefix: newPrefix + "├── TL: ")
            result += visualizeNode(node.topRight, depth: depth + 1, prefix: newPrefix + "├── TR: ")
            result += visualizeNode(node.bottomLeft, depth: depth + 1, prefix: newPrefix + "├── BL: ")
            result += visualizeNode(node.bottomRight, depth: depth + 1, prefix: newPrefix + "└── BR: ")

            return result
        }

        return visualizeNode(root, depth: 0, prefix: "")
    }
}
