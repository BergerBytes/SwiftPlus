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

    public enum ScrollingBehavior {
        case enabled
        case disabled
        case auto
    }

    @available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13.0, *)
    public extension ScrollView {
        /// A ScrollView extension that allows customization of the axis, indicators, and scrolling enabled state, as well as optional bindings for the content size and content offset.
        /// - Parameters:
        ///   - axis: The axis to scroll along (defaults to .vertical).
        ///   - showsIndicators: A Boolean value that determines whether the scroll view displays scroll indicators (defaults to true).
        ///   - scrollingEnabled: A Boolean value that determines whether scrolling is enabled (defaults to true).
        ///   - contentSize: A binding to the size of the scrollable content.
        ///   - contentOffset: A binding to the current offset of the scrollable content.
        ///   - content: A closure returning the content to be displayed in the scroll view.
        static func plus(
            _ axis: Axis.Set = .vertical,
            showsIndicators: Bool = true,
            scrollingEnabled: Bool = true,
            contentSize: Binding<CGSize>? = nil,
            contentOffset: Binding<CGPoint>? = nil,
            @ViewBuilder content: @escaping () -> Content
        ) -> some View {
            _ScrollViewPlus(axis, showsIndicators: showsIndicators, scrollingEnabled: scrollingEnabled, contentSize: contentSize, contentOffset: contentOffset, content: content)
        }
    }

    @available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13.0, *)
    private struct _ScrollViewPlus<Content: View>: View {
        let axis: Axis.Set
        let showsIndicators: Bool
        let scrollingEnabled: Bool
        let contentSize: Binding<CGSize>?
        let contentOffset: Binding<CGPoint>?
        @ViewBuilder
        let content: () -> Content

        @State private var id = UUID()

        init(
            _ axis: Axis.Set = .vertical,
            showsIndicators: Bool = true,
            scrollingEnabled: Bool = true,
            contentSize: Binding<CGSize>? = nil,
            contentOffset: Binding<CGPoint>? = nil,
            @ViewBuilder content: @escaping () -> Content
        ) {
            self.axis = axis
            self.showsIndicators = showsIndicators
            self.scrollingEnabled = scrollingEnabled
            self.contentSize = contentSize
            self.contentOffset = contentOffset
            self.content = content
        }

        var body: some View {
            Group {
                if scrollingEnabled {
                    ScrollView(axis, showsIndicators: showsIndicators) {
                        contentBody
                    }
                } else {
                    contentBody
                }
            }
            .coordinateSpace(name: id)
            .id(id)
        }

        @ViewBuilder
        private var contentBody: some View {
            if contentSize.isNil, contentOffset.isNil {
                content()
            } else {
                content()
                    .onLayout { proxy in
                        let frame = proxy.frame(in: .named(id))

                        let y = -frame.minY
                        let x = -frame.minX
                        contentOffset?.wrappedValue = .init(x: x, y: y)

                        contentSize?.wrappedValue = frame.size
                    }
            }
        }
    }

#endif
