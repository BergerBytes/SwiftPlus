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
        /**
         Creates a new `Color` instance from a given hexadecimal value and alpha component.

         - Parameters:
            - hex: The hexadecimal value to use for the new color, in the format 0xRRGGBB.
            - alpha: The alpha component to use for the new color, in the range 0.0 (fully transparent) to 1.0 (fully opaque). The default value is 1.0.
            - colorSpace: The color space to use for the new color. The default value is `.sRGB`.

         - Returns: A new `Color` instance with the specified color and alpha.
         */
        init(hex: UInt, alpha: Double = 1, colorSpace: Color.RGBColorSpace = .sRGB) {
            // Extract the red, green, and blue components from the hexadecimal value using bitwise operations.
            let red = Double((hex >> 16) & 0xFF) / 255
            let green = Double((hex >> 8) & 0xFF) / 255
            let blue = Double(hex & 0xFF) / 255

            // Call the designated initializer for `Color` with the extracted components, alpha value, and color space.
            self.init(colorSpace, red: red, green: green, blue: blue, opacity: alpha)
        }

        /**
         Creates a new `Color` instance from a given 6-character hexadecimal string, alpha component, and color space.

         - Parameters:
            - hex: The 6-character hexadecimal string to use for the new color, in the format #RRGGBB.
            - alpha: The alpha component to use for the new color, in the range 0.0 (fully transparent) to 1.0 (fully opaque). The default value is 1.0.
            - colorSpace: The color space to use for the new color. The default value is sRGB.

         - Returns: A new `Color` instance with the specified color and alpha.
         */
        init(hex: String, alpha: Double = 1, colorSpace: Color.RGBColorSpace = .sRGB) {
            // Ensure that the hex string has 6 characters and can be parsed as a UInt with radix 16.
            guard hex.count == 7, hex.hasPrefix("#"), let hexValue = UInt(hex.dropFirst(), radix: 16) else {
                // If the hex string is invalid, create a clear color and return it.
                self.init(.clear)
                return
            }

            // Extract the red, green, and blue components from the UInt value using bitwise operations.
            let red = Double((hexValue >> 16) & 0xFF) / 255
            let green = Double((hexValue >> 8) & 0xFF) / 255
            let blue = Double(hexValue & 0xFF) / 255

            // Call the designated initializer for `Color` with the extracted components, alpha value, and color space.
            self.init(colorSpace, red: red, green: green, blue: blue, opacity: alpha)
        }

        /**
         Returns the opaque hexadecimal value of the receiver as a UInt.
         
         This function extracts the red, green, and blue components from the receiver using the `getRed(_:green:blue:alpha:)` method of `UIColor` or `NSColor`, depending on the platform. It then multiplies each component by 255, converts the results to a UInt, and combines them into a single value using bitwise operations. The resulting value is the opaque hexadecimal representation of the color.
         
         - Returns: The opaque hexadecimal value of the receiver as a UInt.
         */
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
