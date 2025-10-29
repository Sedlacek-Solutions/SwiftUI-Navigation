//
//  ArrayTruncationTests.swift
//
//
//  Created by James Sedlacek on 2/10/24.
//

import Testing
@testable import Navigation

struct ArrayTruncationTests {
    @Test func truncateToValidIndex() {
        var numbers = [1, 2, 3, 4, 5]
        numbers.truncate(to: 2)
        #expect(numbers == [1, 2, 3], "Array should be truncated to [1, 2, 3]")
    }

    @Test func truncateToIndexBeyondCount() {
        var numbers = [1, 2, 3, 4, 5]
        numbers.truncate(to: 10)
        #expect(numbers == [1, 2, 3, 4, 5], "Array should remain unchanged")
    }

    @Test func truncateEmptyArray() {
        var emptyArray: [Int] = []
        emptyArray.truncate(to: 2)
        #expect(emptyArray == [], "Empty array should remain unchanged")
    }

    @Test func truncateToIndexZero() {
        var numbers = [1, 2, 3, 4, 5]
        numbers.truncate(to: 0)
        #expect(numbers == [1], "Array should be truncated to [1]")
    }

    @Test func truncateWithNegativeIndex() {
        var numbers = [1, 2, 3, 4, 5]
        numbers.truncate(to: -2)
        #expect(numbers == [1, 2, 3, 4, 5], "Array should remain unchanged")
    }
}
