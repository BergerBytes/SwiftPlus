import Foundation

public extension CGPoint {
    static var zero: CGPoint { .init(x: 0, y: 0) }
    static var one: CGPoint { .init(x: 1, y: 1) }

    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        .init(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    static func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        .init(x: lhs.x / rhs, y: lhs.y / rhs)
    }

    static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        .init(x: lhs.x * rhs, y: lhs.y * rhs)
    }
}

public extension RandomAccessCollection where Element == CGPoint, Index == Int {
    /// Calculate signed area.
    ///
    /// See [Wikipedia](https://en.wikipedia.org/wiki/Centroid#Of_a_polygon)
    ///
    /// - Returns: The signed area
    func signedArea() -> CGFloat {
        if isEmpty { return .zero }

        var sum: CGFloat = 0
        for (index, point) in enumerated() {
            let nextPoint: CGPoint
            if index < count - 1 {
                nextPoint = self[index + 1]
            } else {
                nextPoint = self[0]
            }

            sum += point.x * nextPoint.y - nextPoint.x * point.y
        }

        return sum / 2
    }

    /// Calculate centroid
    ///
    /// See [Wikipedia](https://en.wikipedia.org/wiki/Centroid#Of_a_polygon)
    ///
    /// - Note: If the area of the polygon is zero (e.g. the points are collinear), this returns `nil`.
    ///
    /// - Parameter points: Unclosed points of polygon.
    /// - Returns: Centroid point.
    func centroid() -> CGPoint? {
        if isEmpty { return nil }

        let area = signedArea()
        if area == 0 { return nil }

        var sumPoint: CGPoint = .zero

        for (index, point) in enumerated() {
            let nextPoint: CGPoint
            if index < count - 1 {
                nextPoint = self[index + 1]
            } else {
                nextPoint = self[0]
            }

            let factor = point.x * nextPoint.y - nextPoint.x * point.y
            sumPoint.x += (point.x + nextPoint.x) * factor
            sumPoint.y += (point.y + nextPoint.y) * factor
        }

        return sumPoint / 6 / area
    }

    func mean() -> CGPoint? {
        if isEmpty { return nil }

        return reduce(.zero, +) / CGFloat(count)
    }
}
