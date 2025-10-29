//
//  View+Extensions.swift
//  SwiftUI-Navigation
//
//  Created by James Sedlacek on 5/6/25.
//

import SwiftUI

public extension View {
    /// Associates a destination view with a presented data type for use within a navigation stack.
    ///
    /// This is a convenience wrapper around the standard SwiftUI `navigationDestination(for:destination:)` modifier,
    /// tailored for use with types conforming to `Destination`. The destination view is the presented `Destination` instance itself.
    ///
    /// - Parameter destinationType: The type of `Destination` data that this destination binding supports.
    ///   This should be the metatype (e.g., `MyDestination.self`).
    /// - Returns: A view that has a navigation destination associated with the specified `Destination` data type.
    func navigationDestination<D: Destination>(for destinationType: D.Type) -> some View {
        self.navigationDestination(for: D.self, destination: { $0 })
    }

    /// Presents a sheet when a binding to an optional `Destination` item becomes non-nil.
    ///
    /// This is a convenience wrapper around the standard SwiftUI `sheet(item:onDismiss:content:)` modifier,
    /// tailored for use with types conforming to `Destination`. The content of the sheet is the item itself.
    ///
    /// - Parameters:
    ///   - item: A `Binding` to an optional `Destination` item. When `item` is non-nil,
    ///     the system passes the unwrapped item to the `content` closure, which then provides
    ///     the view for the sheet. If `item` becomes `nil`, the system dismisses the sheet.
    ///   - onDismiss: An optional closure that SwiftUI executes when the sheet dismisses.
    /// - Returns: A view that presents a sheet when the bound item is non-nil.
    func sheet<D: Destination & Identifiable>(item: Binding<D?>, onDismiss: (() -> Void)? = nil) -> some View {
        self.sheet(item: item, onDismiss: onDismiss, content: { $0 })
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public extension View {
    /// Presents a view when a binding to an optional `Destination` item becomes non-nil.
    ///
    /// This is a convenience wrapper around the standard SwiftUI `navigationDestination(item:destination:)` modifier,
    /// tailored for use with types conforming to `Destination`. The destination view is the item itself.
    ///
    /// - Parameter item: A `Binding` to an optional `Destination` item. When `item` is non-nil,
    ///   the system passes the unwrapped item to the `destination` closure, which then provides
    ///   the view to display. If `item` becomes `nil`, the system dismisses the presented view.
    /// - Returns: A view that presents another view when the bound item is non-nil.
    func navigationDestination<D: Destination>(item: Binding<D?>) -> some View {
        self.navigationDestination(item: item, destination: { $0 })
    }
}
