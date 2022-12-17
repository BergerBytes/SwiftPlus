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
#if canImport(Spatial)
    import Spatial

    @available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
    public extension Size3D {
        @inlinable func volume() -> Double {
            guard depth.isFinite, width.isFinite, height.isFinite else {
                return .infinity
            }

            return depth * width * height
        }
    }

    @available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
    public extension Vector3D {
        /// Returns a new vector from a single-precision vector.
        ///
        /// - Parameter xyz: The source vector.
        @inlinable init(_ xyz: simd_float3) {
            self.init(simd_double3(xyz))
        }
    }
#endif
