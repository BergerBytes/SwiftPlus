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

#if canImport(SwiftUI)

    import SwiftUI

    @available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13.0, *)
    public extension View {
        func onLayout(
            perform action: ((GeometryProxy) -> Void)? = nil
        ) -> some View {
            modifier(LayoutActionModifier(action: action))
        }
    }

    @available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13.0, *)
    public struct LayoutActionModifier: ViewModifier {
        /// This action is run after each time the view changes.
        let action: ((GeometryProxy) -> Void)?

        public func body(content: Content) -> some View {
            content
                .background(
                    GeometryReader { proxy in
                        layoutWatcher(proxy)
                    }
                )
        }

        func layoutWatcher(_ proxy: GeometryProxy) -> some View {
            /// This runs the action after each time the view is
            /// updated.
            Task { @MainActor in
                action?(proxy)
            }
            let result = Color.clear
                /// This runs the action when the view first appears.
                .onAppear {
                    action?(proxy)
                }
            return result
        }
    }

#endif
