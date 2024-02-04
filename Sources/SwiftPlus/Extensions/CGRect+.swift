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

import CoreGraphics
import Foundation

// MARK: - CGRect + Center

public extension CGRect {
    /// Creates a rectangle with the given center and dimensions
    /// - Parameters:
    ///   - center: The center of the new rectangle
    ///   - size: The dimensions of the new rectangle
    @inlinable init(center: CGPoint, size: CGSize) {
        self.init(x: center.x - size.width / 2, y: center.y - size.height / 2, width: size.width, height: size.height)
    }

    /// The coordinates of this rectangles center
    @inlinable var center: CGPoint {
        get { CGPoint(x: centerX, y: centerY) }
        set { centerX = newValue.x; centerY = newValue.y }
    }

    /// The x-coordinate of this rectangles center
    /// - Note: Acts as a settable midX
    /// - Returns: The x-coordinate of the center
    @inlinable var centerX: CGFloat {
        get { midX }
        set { origin.x = newValue - width * 0.5 }
    }

    /// The y-coordinate of this rectangles center
    /// - Note: Acts as a settable midY
    /// - Returns: The y-coordinate of the center
    @inlinable var centerY: CGFloat {
        get { midY }
        set { origin.y = newValue - height * 0.5 }
    }

    // MARK: - "with" convenience functions

    /// Same-sized rectangle with a new center
    /// - Parameters center: The new center, ignored if nil
    /// - Returns: A new rectangle with the same size and a new center
    @inlinable func with(center: CGPoint?) -> CGRect {
        CGRect(center: center ?? self.center, size: size)
    }

    /// Same-sized rectangle with a new center-x
    /// - Parameter centerX: The new center-x, ignored if nil
    /// - Returns: A new rectangle with the same size and a new center
    @inlinable func with(centerX: CGFloat?) -> CGRect {
        CGRect(center: CGPoint(x: centerX ?? self.centerX, y: centerY), size: size)
    }

    /// Same-sized rectangle with a new center-y
    /// - Parameter centerY: The new center-y, ignored if nil
    /// - Returns: A new rectangle with the same size and a new center
    @inlinable func with(centerY: CGFloat?) -> CGRect {
        CGRect(center: CGPoint(x: centerX, y: centerY ?? self.centerY), size: size)
    }

    /// Same-sized rectangle with a new center-x and center-y
    /// - Parameters:
    ///   - centerX:  The new center-x, ignored if nil
    ///   - centerY: The new center-y, ignored if nil
    /// - Returns: A new rectangle with the same size and a new center
    @inlinable func with(centerX: CGFloat?, centerY: CGFloat?) -> CGRect {
        CGRect(center: CGPoint(x: centerX ?? self.centerX, y: centerY ?? self.centerY), size: size)
    }
}

// MARK: - CGRect + Measurements

public extension CGRect {
    /// The diagonal of the rect.
    @inlinable var diagonal: CGFloat {
        hypot(width, height)
    }

    /// The diagonal of the rect squared.
    @inlinable var diagonalSquared: CGFloat {
        pow(width, 2) + pow(height, 2)
    }
}

// MARK: - CGRect + Subdivide

public extension CGRect {
    @inlinable var topLeftRect: CGRect {
        CGRect(x: minX, y: minY, width: width * 0.5, height: height * 0.5)
    }

    @inlinable var topRightRect: CGRect {
        CGRect(x: midX, y: minY, width: width * 0.5, height: height * 0.5)
    }

    @inlinable var bottomLeftRect: CGRect {
        CGRect(x: minX, y: midY, width: width * 0.5, height: height * 0.5)
    }

    @inlinable var bottomRightRect: CGRect {
        CGRect(x: midX, y: midY, width: width * 0.5, height: height * 0.5)
    }
}
