# SwiftUI-Navigation

[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![GitHub stars](https://img.shields.io/github/stars/JamesSedlacek/SwiftUI-Navigation.svg)](https://github.com/JamesSedlacek/SwiftUI-Navigation/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/JamesSedlacek/SwiftUI-Navigation.svg?color=blue)](https://github.com/JamesSedlacek/SwiftUI-Navigation/network)
[![GitHub contributors](https://img.shields.io/github/contributors/JamesSedlacek/SwiftUI-Navigation.svg?color=blue)](https://github.com/JamesSedlacek/SwiftUI-Navigation/network)
<a href="https://github.com/JamesSedlacek/SwiftUI-Navigation/pulls"><img src="https://img.shields.io/github/issues-pr/JamesSedlacek/SwiftUI-Navigation" alt="Pull Requests Badge"/></a>
<a href="https://github.com/JamesSedlacek/SwiftUI-Navigation/issues"><img src="https://img.shields.io/github/issues/JamesSedlacek/SwiftUI-Navigation" alt="Issues Badge"/></a>

## Description

`SwiftUI-Navigation` is a **lightweight** SwiftUI navigation library.
- Leverages 1st-party APIs `NavigationStack` & `NavigationDestination`.
- Never be confused about `NavigationLink` or `NavigationPath` again! (You don't need them)
- Type-Safe Navigation (better performance than type-erasing).
- Centralized Navigation Logic.
- Dynamic Navigation Stack Management.
- Unit Tested protocol implementations.
- Zero 3rd party dependencies.

<br>

## Table of Contents
1. [Requirements](#requirements)
2. [Installation](#installation)
3. [Getting Started](#getting-started)
4. [Passing Data Example](#passing-data-example)
5. [View Extensions](#view-extensions)
6. [Under the hood](#under-the-hood)

<br>

## Requirements

| Platform | Minimum Version |
|----------|-----------------|
| iOS      | 16.0            |
| macOS    | 13.0            |
| tvOS     | 16.0            |
| watchOS  | 9.0             |

<br>

## Installation

You can install `SwiftUI-Navigation` using the Swift Package Manager.

1. In Xcode, select `File` > `Add Package Dependencies`.
<br>

2. Copy & paste the following into the `Search or Enter Package URL` search bar.
```
https://github.com/JamesSedlacek/SwiftUI-Navigation.git
```
<br>

3. Xcode will fetch the repository & the `SwiftUI-Navigation` library will be added to your project.

<br>

## Getting Started

1. Create a `Destination` enum that conforms to the `Destination` protocol.

``` swift
import Navigation
import SwiftUI

enum ExampleDestination: Destination {
    case detail
    case settings
    
    var body: some View {
        switch self {
        case .detail:
            DetailView()
        case .settings:
            SettingsView()
        }
    }
}
```

2. Create a `DestinationState` object and wrap your `RootView` with a `Navigator`.

``` swift
import SwiftUI
import Navigation

struct ContentView: View {
    @DestinationState private var destinations: [ExampleDestination] = []

    var body: some View {
        Navigator(path: $destinations) {
            Button("Go to Settings") {
                destinations.navigate(to: .settings)
            }
        }
    }
}
```

3. Handle navigation using the `DestinationState` functions

```swift
/// Navigate back in the stack by a specified count.
func navigateBack(_ count: Int)

/// Navigate back to a specific destination in the stack.
func navigateBack(to destination: Destination)

/// Navigate to the root of the stack by emptying it.
func navigateToRoot()

/// Navigate to a specific destination by appending it to the stack.
func navigate(to destination: Destination)

/// Navigate to multiple destinations by appending them to the stack.
func navigate(to destinations: [Destination])

/// Replace the current stack with new destinations.
func replace(with destinations: [Destination])
```

<br>

## Passing Data Example

```swift
import Navigation
import SwiftUI

enum ContentDestination: Destination {
    case detail(Color)
    case settings

    var body: some View {
        switch self {
        case .detail(let color):
            ColorDetail(color: color)
        case .settings:
            SettingsView()
        }
    }
}

struct ContentView: View {
    @DestinationState private var destinations: [ContentDestination] = []
    private let colors: [Color] = [.red, .green, .blue]

    var body: some View {
        Navigator(path: $destinations) {
            List(colors, id: \.self) { color in
                color
                    .onTapGesture {
                        destinations.navigate(to: .detail(color))
                    }
            }
        }
    }
}

struct ColorDetail: View {
    private let color: Color

    init(color: Color) {
        self.color = color
    }

    var body: some View {
        color.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
```

<br>

## View Extensions

`SwiftUI-Navigation` provides several `View` extensions to simplify common navigation and presentation patterns when working with `Destination` types.

### `navigationDestination(for: DestinationType.self)`

This extension is a convenience wrapper around the standard SwiftUI `navigationDestination(for:destination:)` modifier. It's tailored for use with types conforming to `Destination`, automatically using the `Destination` instance itself as the destination view.

```swift
// Usage within a view:
// SomeView().navigationDestination(for: MyDestination.self)
// This is often handled automatically by Navigator.
```
`Navigator` uses this extension internally to set up navigation for your `Destination` enum.

### `sheet(item:onDismiss:)`

Presents a sheet when a binding to an optional `Destination & Identifiable` item becomes non-nil. The content of the sheet is the `Destination` item itself.

-   `item`: A `Binding` to an optional `Destination & Identifiable` item.
-   `onDismiss`: An optional closure executed when the sheet dismisses.

**Note:** The `Destination` type used with this modifier must also conform to `Identifiable`.
```swift
import SwiftUI
import Navigation

// Ensure your Destination enum conforms to Identifiable.
// For enums with associated values, you might need to add an explicit `id`.
enum ModalDestination: Destination, Identifiable {
    case helpPage
    case userDetails(id: String)

    // Example of making it Identifiable
    var id: String {
        switch self {
        case .helpPage:
            return "helpPage"
        case .userDetails(let id):
            return "userDetails-\(id)"
        }
    }

    var body: some View {
        switch self {
        case .helpPage:
            HelpView() // Placeholder
        case .userDetails(let id):
            UserDetailsView(userID: id) // Placeholder
        }
    }
}

struct MyContentView: View {
    @State private var sheetItem: ModalDestination?

    var body: some View {
        Button("Show Help Sheet") {
            sheetItem = .helpPage
        }
        .sheet(item: $sheetItem)
    }
}

// Placeholder Views for example
struct HelpView: View { var body: some View { Text("Help Information") } }
struct UserDetailsView: View {
    let userID: String
    var body: some View { Text("Details for user \(userID)") }
}
```

### `navigationDestination(item:)` (iOS 17.0+)

Available on iOS 17.0+, macOS 14.0+, tvOS 17.0+, watchOS 10.0+.

Presents a view using `navigationDestination(item:destination:)` when a binding to an optional `Destination` item becomes non-nil. The destination view is the `Destination` item itself. This is useful for modal-style presentations or alternative navigation flows that don't necessarily push onto the main `NavigationStack`.

-   `item`: A `Binding` to an optional `Destination` item.
```swift
import SwiftUI
import Navigation

// Assuming MyDetailDestination is a Destination enum
// enum MyDetailDestination: Destination { case info, settings ... }

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
struct AnotherScreen: View {
    @State private var presentedDetail: MyDetailDestination? // MyDetailDestination conforms to Destination

    var body: some View {
        Button("Show Info Modally") {
            presentedDetail = .info // Assuming .info is a case in MyDetailDestination
        }
        .navigationDestination(item: $presentedDetail)
    }
}
```

<br>

## Under the hood

The `Navigator` essentially wraps your view with a `NavigationStack`. It uses the `navigationDestination(for: DestinationType.self)` view extension (detailed in the "View Extensions" section) to automatically handle presenting the views associated with your `Destination` types.
```swift
// Simplified structure of Navigator's body:
NavigationStack(path: $path) { // $path is your @DestinationState's binding
    rootContent()
        .navigationDestination(for: DestinationType.self) // Uses the Destination-specific extension
}
```
