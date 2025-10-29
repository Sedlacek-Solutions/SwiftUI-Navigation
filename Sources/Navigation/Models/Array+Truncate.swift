//
//  Array+Truncate.swift
//
//  Created by James Sedlacek on 12/29/23.
//

import Foundation

extension Array {
    /// Truncates the array up to the specified index.
    ///
    /// This method mutates the original array, keeping the elements up to the given index (inclusive).
    /// If the index is out of bounds (negative, or greater than or equal to the array's count),
    /// the array remains unchanged.
    ///
    /// - Parameter index: The index up to which the array should be truncated.
    ///
    /// Example Usage:
    /// ```
    /// var numbers = [1, 2, 3, 4, 5]
    /// numbers.truncate(to: 2)
    /// // numbers is now [1, 2, 3] (elements at indices 0, 1, 2)
    /// ```
    mutating func truncate(to index: Int) {
        guard index >= 0 && index < self.count else {
            // If index is invalid (e.g., negative, or >= count), or if the array is empty,
            // do nothing. This maintains the array if truncation isn't sensible.
            return
        }
        // Keep elements from index 0 up to and including 'index'.
        // The slice self[0...index] is equivalent to self[..<(index + 1)].
        // The guard ensures that 'index + 1' will not exceed 'self.count'.
        self = Array(self[..<(index + 1)])
    }
}
