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

#if canImport(SwiftUI) && (canImport(UIKit) || canImport(AppKit))
    import SwiftUI

    #if canImport(UIKit)
        import UIKit
    #elseif canImport(AppKit)
        import AppKit
    #endif

    @available(iOS 13.0, macOS 10.15, watchOS 7.0, tvOS 14.0, *)
    public extension Color {
        init(hex: UInt, alpha: Double = 1) {
            self.init(
                .sRGB,
                red: Double((hex >> 16) & 0xFF) / 255,
                green: Double((hex >> 08) & 0xFF) / 255,
                blue: Double((hex >> 00) & 0xFF) / 255,
                opacity: alpha
            )
        }

        #if canImport(UIKit) || canImport(AppKit)
            @available(iOS 14.0, *)
            @available(macOS 11, *)
            func opaqueHex() -> UInt {
                var red: CGFloat = 0
                var green: CGFloat = 0
                var blue: CGFloat = 0

                #if canImport(UIKit)
                    let color = UIColor(self)
                #elseif canImport(AppKit)
                    let color = NSColor(self)
                #endif

                color.getRed(&red, green: &green, blue: &blue, alpha: nil)

                return (UInt(red * 255.0) << 16)
                    + (UInt(green * 255.0) << 8)
                    + UInt(blue * 255.0)
            }
        #endif
    }
#endif
