//
//  Navigator.swift
//  SwiftUI-Navigation
//

import SwiftUI

/// A thin convenience wrapper around `NavigationStack` that
/// drives navigation from an external `[DestinationType]` array.
///
/// `Navigator` lets you keep the navigation “path” outside
/// of your view hierarchy (e.g. in `@AppStorage` via `@DestinationState`)
/// while still enjoying type-safe `NavigationStack` behaviour.
/// The view creates its own `NavigationStack` under-the-hood
/// and forwards a binding to the caller-supplied `path`.
///
/// Usage:
/// ```swift
/// enum MyDestination: Destination {                // 1️⃣ Conform to Destination
///     case profile(Int)                   //    Your destination cases
///
///     var body: some View {               //    Each case returns a view
///         switch self {
///         case .profile(let id):
///             ProfileView(id: id)
///         }
///     }
/// }
///
/// struct RootView: View {
///     @DestinationState private var path: [MyDestination] = []   // 2️⃣ Persist the path
///
///     var body: some View {
///         Navigator(path: $path) {             // 3️⃣ Wrap your root UI
///             VStack {
///                 Button("Show profile") {
///                     path.navigate(to: .profile(42))
///                 }
///             }
///         }
///     }
/// }
/// ```
///
/// - Parameters:
///   - DestinationType: The enum/struct you use to describe destinations.
///                Must conform to `Destination`.
///   - RootContent: The root view shown at the bottom of the stack.
public struct Navigator<DestinationType: Destination, RootContent: View>: View {
    @Binding private var path: [DestinationType]
    private let rootContent: () -> RootContent

    public init(
        path: Binding<[DestinationType]>,
        @ViewBuilder rootContent: @escaping () -> RootContent
    ) {
        self._path = path
        self.rootContent = rootContent
    }

    public var body: some View {
        NavigationStack(path: $path) {
            rootContent()
                .navigationDestination(for: DestinationType.self)
        }
    }
}
