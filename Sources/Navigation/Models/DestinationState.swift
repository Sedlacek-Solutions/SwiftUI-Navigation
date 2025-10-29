//
//  DestinationState.swift
//
//  Created by James Sedlacek on 12/15/23.
//

import SwiftUI

/// A property-wrapper that keeps a stack of `Destination` values in `UserDefaults`
/// (via `@AppStorage`) and exposes it to SwiftUI as mutable state.
///
/// The encoded array is stored under the supplied key (default: `"DestinationStateKey"`),
/// allowing the navigation stack to survive app launches or scene re-creation.
///
/// Basic usage:
///
/// ```swift
/// enum AppDestination: String, Destination {
///     case home, detail, settings
/// }
///
/// struct ContentView: View {
///     @DestinationState var destinations: [AppDestination] = [.home]   // stored under "DestinationStateKey"
///
///     var body: some View { /* … */ }
/// }
///
/// // Custom key / UserDefaults instance
/// @DestinationState("OnboardingDestinations", store: .standard)
/// var onboarding: [OnboardingDestination] = [.welcome]
/// ```
///
/// Access patterns:
/// • Read/Write: `destinations.append(.detail)`
/// • Bindable:    `$destinations` to drive a `NavigationStack` or similar.
///
/// - Note: Encoding/decoding uses `JSONEncoder` / `JSONDecoder`. If encoding
///   fails the `defaultValue` is returned silently.
@MainActor
@propertyWrapper
public struct DestinationState<T: Destination>: DynamicProperty {
    @AppStorage private var storage: Data
    private let encoder: JSONEncoder = .init()
    private let decoder: JSONDecoder = .init()
    private let defaultValue: [T]

    public var wrappedValue: [T] {
        get {
            guard let decoded = try? decoder.decode([T].self, from: storage) else {
                return defaultValue
            }
            return decoded
        }
        nonmutating set {
            guard let encoded = try? encoder.encode(newValue) else { return }
            storage = encoded
        }
    }

    public var projectedValue: Binding<[T]> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }

    public init(
        wrappedValue: [T],
        _ key: String = "DestinationStateKey",
        store: UserDefaults? = nil
    ) {
        defaultValue = wrappedValue
        let initialData = (try? encoder.encode(wrappedValue)) ?? Data()
        _storage = .init(wrappedValue: initialData, key, store: store)
    }
}
