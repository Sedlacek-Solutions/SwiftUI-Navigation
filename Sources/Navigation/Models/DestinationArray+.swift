//
//  DestinationArray+.swift
//
//  Created by James Sedlacek on 12/16/23.
//

import SwiftUI

@MainActor
public extension Array where Element: Destination {

    /// Navigate back in the navigation stack by a specified number of destinations.
    ///
    /// - Parameter count: The number of destinations to navigate back by.
    /// If the count exceeds the number of destinations in the stack, the stack is emptied.
    mutating func navigateBack(_ count: Int = 1) {
        guard count > 0 else { return }
        guard count <= self.count else {
            self = .init()
            return
        }
        self.removeLast(count)
    }

    /// Navigate back to a specific destination in the stack, removing all destinations that come after it.
    ///
    /// - Parameter destination: The destination to navigate back to.
    /// If the destination does not exist in the stack, no action is taken.
    mutating func navigateBack(to destination: Element) {
        // Check if the destination exists in the stack
        if let index = self.lastIndex(where: { $0 == destination }) {
            // Remove destinations above the specified destination
            self.truncate(to: index)
        }
    }

    /// Resets the navigation stack to its initial state, effectively navigating to the root destination.
    mutating func navigateToRoot() {
        self = []
    }

    /// Appends a new destination to the navigation stack, moving forward in the navigation flow.
    ///
    /// - Parameter destination: The destination to navigate to.
    mutating func navigate(to destination: Element) {
        self.append(destination)
    }

    /// Appends multiple new destinations to the navigation stack.
    ///
    /// - Parameter destinations: An array of destinations to append to the navigation stack.
    mutating func navigate(to destinations: [Element]) {
        self += destinations
    }

    /// Replaces the current navigation stack with a new set of destinations.
    ///
    /// - Parameter destinations: An array of new destinations to set as the navigation stack.
    mutating func replace(with destinations: [Element]) {
        self = destinations
    }
}
