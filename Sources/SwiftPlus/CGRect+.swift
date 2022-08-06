import Foundation

// MARK: - CGRect + Center

public extension CGRect {
    /// Creates a rectangle with the given center and dimensions
    /// - Parameters:
    ///   - center: The center of the new rectangle
    ///   - size: The dimensions of the new rectangle
    init(center: CGPoint, size: CGSize) {
        self.init(x: center.x - size.width / 2, y: center.y - size.height / 2, width: size.width, height: size.height)
    }

    /// The coordinates of this rectangles center
    var center: CGPoint {
        get { CGPoint(x: centerX, y: centerY) }
        set { centerX = newValue.x; centerY = newValue.y }
    }

    /// The x-coordinate of this rectangles center
    /// - Note: Acts as a settable midX
    /// - Returns: The x-coordinate of the center
    var centerX: CGFloat {
        get { midX }
        set { origin.x = newValue - width * 0.5 }
    }

    /// The y-coordinate of this rectangles center
    /// - Note: Acts as a settable midY
    /// - Returns: The y-coordinate of the center
    var centerY: CGFloat {
        get { midY }
        set { origin.y = newValue - height * 0.5 }
    }

    // MARK: - "with" convenience functions

    /// Same-sized rectangle with a new center
    /// - Parameters center: The new center, ignored if nil
    /// - Returns: A new rectangle with the same size and a new center
    func with(center: CGPoint?) -> CGRect {
        CGRect(center: center ?? self.center, size: size)
    }

    /// Same-sized rectangle with a new center-x
    /// - Parameter centerX: The new center-x, ignored if nil
    /// - Returns: A new rectangle with the same size and a new center
    func with(centerX: CGFloat?) -> CGRect {
        CGRect(center: CGPoint(x: centerX ?? self.centerX, y: centerY), size: size)
    }

    /// Same-sized rectangle with a new center-y
    /// - Parameter centerY: The new center-y, ignored if nil
    /// - Returns: A new rectangle with the same size and a new center
    func with(centerY: CGFloat?) -> CGRect {
        CGRect(center: CGPoint(x: centerX, y: centerY ?? self.centerY), size: size)
    }

    /// Same-sized rectangle with a new center-x and center-y
    /// - Parameters:
    ///   - centerX:  The new center-x, ignored if nil
    ///   - centerY: The new center-y, ignored if nil
    /// - Returns: A new rectangle with the same size and a new center
    func with(centerX: CGFloat?, centerY: CGFloat?) -> CGRect {
        CGRect(center: CGPoint(x: centerX ?? self.centerX, y: centerY ?? self.centerY), size: size)
    }
}
